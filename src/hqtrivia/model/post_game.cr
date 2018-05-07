require "./int_coerce"
require "json"

module HqTrivia
  module Model
    # Sent from the server once the game has fully ended.
    class PostGame
      include WebSocketMessage

      JSON.mapping({
        type:    String,
        ts:      Time,
        show_id: {key: "showId", type: Int32, converter: IntCoerce},
        c:       Int32,
        sent:    Time,
      })
    end
  end
end
