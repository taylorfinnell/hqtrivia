module HqTrivia
  module Connection
    # Local connection, given an array of messaegs, it parses them and yields
    # them to the block
    class Local
      include Interface

      def initialize(@raw_messages : Array(String))
        @open = false
      end

      # Connect to a *show* using the given *coordinator*
      def connect(coordinator : Coordinator)
        @open = true
      end

      # True if open, false otherwise
      def open?
        @open
      end

      # Starts the connections
      def run
        @raw_messages.each do |msg|
          @on_raw_message_callback.try &.call msg
          @on_message_callback.try &.call Model::RawWebSocketMessage.decode(msg)
        end
      end

      # Sends the *message* to the connection
      def send_message(message : String)
        HqTrivia.logger.debug("[LocalConnection] Sent message: #{message}")
      end
    end
  end
end
