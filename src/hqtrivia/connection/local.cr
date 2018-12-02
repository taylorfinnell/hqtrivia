module HqTrivia
  module Connection
    # Local connection, given an array of messaegs, it parses them and yields
    # them to the block
    class Local
      include Interface

      def initialize(@raw_messages : Array(String))
      end

      # Called anytime a valid websocket message is sent
      def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
        @on_message_callback = block
      end

      # Called on any websocket message, sending the raw json to the block
      def on_raw_message(&block : String ->)
        @on_raw_message_callback = block
      end

      # Connect to a *show* using the given *coordinator*
      def connect(show : Model::Show, coordinator : Coordinator)
        @raw_messages.each do |msg|
          @on_raw_message_callback.try &.call msg
          @on_message_callback.try &.call Model::RawWebSocketMessage.decode(msg)
        end
      end
    end
  end
end
