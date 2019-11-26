module HqTrivia
  module Model
    class HeartFinalistUploadUpdate
      include WebSocketMessage

      JSON.mapping({
        type: String,
      })
    end
  end
end
