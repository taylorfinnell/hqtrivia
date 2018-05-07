require "json"

module HqTrivia
  module Model
    # Sent from server when a user is kicked.
    class Kicked
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        ts:       Time,
        user_id:  {key: "userId", type: Int32},
        username: String,
        c:        Int32,
        sent:     Time,
      })
    end
  end
end
