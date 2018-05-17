require "http/client"
require "http/web_socket"

module HqTrivia
  module Connection
    # A connection that connects to the current shows websocket and streams
    # messages to the bot.
    class Hq
      include Interface

      class HttpException < Exception
      end

      # Yields a `Model::WebSocketMessage`
      def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
        @on_message_callback = block
      end

      def on_raw_message(&block : String ->)
        @on_raw_message_callback = block
      end

      # Yields a `Model::Show` if a show is active, otherwise nil
      def on_show(&block : HqTrivia::Model::Show? ->)
        @on_show = block
      end

      # Connects to the HQ websocket
      def connect(blocking = true, record_network = false)
        while show = current_show
          @on_show.try &.call show

          break if show.active || !blocking

          HqTrivia.logger.debug("No active show")
          sleep 5
        end

        open_socket(show, record_network) if show.active
      end

      private def open_socket(show, record_network)
        HqTrivia.logger.debug("Connecting...")

        socket = HTTP::WebSocket.new(show.socket_url.not_nil!, headers: websocket_headers)

        HqTrivia.logger.debug("Connected...")

        socket.on_close do
          connect(false) # don't block, either the game is still active or it is not
        end

        socket.on_message do |json|
          @on_raw_message_callback.try &.call json
          @on_message_callback.try &.call Model::RawWebSocketMessage.decode(json)
        end

        socket.run
      end

      private def current_show
        connection_failed = ->(ex : Exception) do
          HqTrivia.logger.debug("Connection to HQ server failed...retrying. #{ex}")
        end

        retryable(on: HttpException, tries: 5, sleep: 1, callback: connection_failed) do
          resp = HTTP::Client.get(current_show_url, headers: authorization_header)

          if (200..299).includes?(resp.status_code)
            Model::Show.from_json(resp.body)
          else
            raise HttpException.new("#{resp.body} (#{resp.status_code})")
          end
        end
      end

      private def current_show_url
        "https://api-quiz.hype.space/shows/now?type=hq"
      end

      private def authorization_header
        HTTP::Headers{"Authorization" => "Bearer #{authorization_token}"}
      end

      private def authorization_token
        ENV["AUTHORIZATION_TOKEN"]?
      end

      private def websocket_headers
        HTTP::Headers{
          "x-hq-client"     => "iOS/1.2.17",
          "x-hq-stk"        => "MQ==",
          "Host"            => "api-quiz.hype.space",
          "Connection"      => "Keep-Alive",
          "Accept-Encoding" => "gzip",
          "User-Agent"      => "okhttp/3.8.0",
        }.merge!(authorization_header)
      end
    end
  end
end
