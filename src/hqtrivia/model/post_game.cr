module HqTrivia
  module Model
    # Sent from the server once the game has fully ended.
    class PostGame
      include WebSocketMessage

      JSON.mapping({
        type:    String,
        ts:      String,
        show_id: {key: "showId", type: String},
        c:       Int32,
        sent:    String,
      })
    end
  end
end
