module HqTrivia
  module Model
    # Sent from the server when the broadcast has ended, this can either be
    # because the show has actually ended, or your client lost connection.
    class BroadcastEnded
      include WebSocketMessage

      JSON.mapping({
        type:   String,
        ts:     Time,
        reason: String?,
        sent:   Time,
      })
    end
  end
end
