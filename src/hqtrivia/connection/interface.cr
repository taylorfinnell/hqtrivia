module HqTrivia
  module Connection
    module Interface
      # Yields a `Model::WebSocketMessage`
      def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
        @on_message_callback = block
      end

      # Yields raw JSON to the block
      def on_raw_message(&block : String ->)
        @on_raw_message_callback = block
      end

      def on_client_ping(&block : String ->)
        @on_client_ping_callback = block
      end

      def on_server_pong(&block : String ->)
        @on_server_pong_callback = block
      end

      # Connect to a *show* using the given *coordinator*
      abstract def connect(coordinator : Coordinator)

      # Starts the connection after connecting
      abstract def run

      # Sends the *message* to the connection
      abstract def send_message(message : String)

      # True if connection is open, false otherwise
      abstract def open?
    end
  end
end
