module HqTrivia
  module Connection
    module Interface
      # Called anytime a valid websocket message is sent
      abstract def on_message(&block : HqTrivia::Model::WebSocketMessage ->)

      # Called on any websocket message, sending the raw json to the block
      abstract def on_raw_message(&block : String ->)

      # Connect to a *show* using the given *coordinator*
      abstract def connect(show : Model::Show, coordinator : Coordinator)
    end
  end
end
