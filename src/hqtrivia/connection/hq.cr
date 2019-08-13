require "http/client"
require "http/web_socket"
require "retrycr"

module HqTrivia
  module Connection
    # A connection that connects to the current shows websocket and streams
    # messages to the bot.
    class Hq
      include Interface

      # :nodoc:
      @socket : HTTP::WebSocket?

      # :nodoc:
      @open : Bool

      # :nodoc:
      MAX_RETRIES = 30

      def initialize(@raw_messages_only = false)
        @open = false
        @subbed = false
        @retry_count = 0
        @ping_count = 1
      end

      # Connects to the HQ websocket
      def connect(coordinator : Coordinator)
        show = coordinator.current_show

        if show && show.active
          @socket = open_socket(show, coordinator)
          @open = true
          subscribe(show, coordinator)
          heartbeat
          @socket
        else
          HqTrivia.logger.info "Not connecting show (#{coordinator.country}) is no longer active"
        end
      end

      # Returns true if the connection is open, false otherwise
      def open?
        @open
      end

      # Pings the connection with the optional *message*
      def ping
        @socket.not_nil!.ping(@ping_count.to_s)

        if @on_client_ping_callback
          @on_client_ping_callback.try &.call @ping_count.to_s
        end

        @ping_count += 1
      end

      # Starts the connection, you must call #connect first
      def run
        return unless @open
        @socket.not_nil!.run
      end

      # Sends the *message* to the connection, raises if the connection is not open
      def send_message(message : String)
        raise "Connection not open" unless @open
        @socket.not_nil!.send(message)
        HqTrivia.logger.debug("[HQ Connection] Sent msg #{message}")
      end

      private def subscribe(show, coordinator)
        if !@subbed
          msg = {
            "type"        => "subscribe",
            "broadcastId" => show.broadcast.try(&.broadcast_id),
            "authToken"   => HqTrivia.auth.token(coordinator.country),
          }
          send_message(msg.to_json)
          @subbed = true
        end
      end

      private def heartbeat
        spawn do
          loop do
            if !@open
              @retry_count += 1
              @subbed = false

              if @retry_count > MAX_RETRIES
                HqTrivia.logger.debug("Hit max retries, aborting")
                break
              else
                HqTrivia.logger.debug("Connection not open, retrying")
                next
              end
            else
              # Connection is open, reset retries
              @retry_count = 0
            end

            ping

            sleep 5
          end
        end
      end

      # :nodoc:
      private def open_socket(show, coordinator)
        HqTrivia.logger.debug("Connecting: #{coordinator.country}")

        socket = HTTP::WebSocket.new(show.socket_url.not_nil!, headers: HqTrivia.auth.headers(coordinator.country))

        HqTrivia.logger.debug("Connected: #{coordinator.country}")

        socket.on_close do
          @open = false
          connect(coordinator)
        end

        socket.on_message do |json|
          @on_raw_message_callback.try &.call json

          if @raw_messages_only == false
            @on_message_callback.try &.call Model::RawWebSocketMessage.decode(json)
          end
        end

        socket.on_pong do |str|
          if @on_server_pong_callback
            @on_server_pong_callback.try &.call str
          end
        end

        socket
      end
    end
  end
end
