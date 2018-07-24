require "http/client"
require "http/web_socket"
require "retrycr"

module HqTrivia
  module Connection
    # A connection that connects to the current shows websocket and streams
    # messages to the bot.
    class Hq
      include Interface

      # Yields a `Model::WebSocketMessage`
      def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
        @on_message_callback = block
      end

      def on_raw_message(&block : String ->)
        @on_raw_message_callback = block
      end

      # Connects to the HQ websocket
      def connect(show : Model::Show, coordinator : Coordinator)
        if coordinator.current_show.active
          open_socket(show, coordinator)
        else
          HqTrivia.logger.info "Not connecting show (#{coordinator.country}) is no longer active"
        end
      end

      private def open_socket(show, coordinator)
        HqTrivia.logger.debug("Connecting: #{coordinator.country}")

        socket = HTTP::WebSocket.new(show.socket_url.not_nil!, headers: websocket_headers(coordinator))

        HqTrivia.logger.debug("Connected: #{coordinator.country}")

        socket.on_close do
          connect(show, coordinator)
        end

        socket.on_message do |json|
          @on_raw_message_callback.try &.call json
          @on_message_callback.try &.call Model::RawWebSocketMessage.decode(json)
        end

        socket.run
      end

      private def websocket_headers(coordinator)
        HTTP::Headers{
          "x-hq-client"     => "iOS/1.2.17",
          "x-hq-stk"        => "MQ==",
          "Host"            => "api-quiz.hype.space",
          "Connection"      => "Keep-Alive",
          "Accept-Encoding" => "gzip",
          "User-Agent"      => "okhttp/3.8.0",
        }.merge!(HqTrivia.auth.header(coordinator.country))
      end
    end
  end
end
