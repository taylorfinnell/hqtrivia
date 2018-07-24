module HqTrivia
  module Connection
    class Local
      include Interface

      def initialize(@raw_messages : Array(String))
      end

      def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
        @on_message_callback = block
      end

      def on_raw_message(&block : String ->)
        @on_raw_message_callback = block
      end

      def connect(show : Model::Show, coordinator : Coordinator)
        @raw_messages.each do |msg|
          @on_raw_message_callback.try &.call msg
          @on_message_callback.try &.call Model::RawWebSocketMessage.decode(msg)
        end
      end
    end
  end
end
