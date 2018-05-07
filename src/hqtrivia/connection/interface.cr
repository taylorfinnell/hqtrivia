module HqTrivia
  module Connection
    module Interface
      abstract def on_show(&block : HqTrivia::Model::Show? ->)
      abstract def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
      abstract def on_raw_message(&block : String ->)
      abstract def connect(async = false, record_network = false)
    end
  end
end
