module HqTrivia
  module Connection
    module Interface
      abstract def on_show(&block : HqTrivia::Model::Show? ->)
      abstract def on_message(&block : HqTrivia::Model::WebSocketMessage ->)
      abstract def connect(async = false)
    end
  end
end
