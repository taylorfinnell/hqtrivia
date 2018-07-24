module HqTrivia
  module Connection
    module Interface
      abstract def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
      abstract def on_raw_message(&block : String ->)
      abstract def connect(show : Model::Show, coordinator : Coordinator)
    end
  end
end
