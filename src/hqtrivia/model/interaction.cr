module HqTrivia
  module Model
    # Sent from the server when a user intercts with the game, for instance a
    # chat message.
    class Interaction
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        ts:       Time,
        item_id:  {key: "itemId", type: String},
        user_id:  {key: "userId", type: Int32},
        metadata: Metadata,
        sent:     Time,
      })

      class Metadata
        JSON.mapping({
          user_id:     {key: "userId", type: Int32},
          message:     String,
          avatar_url:  {key: "avatarUrl", type: String?},
          interaction: String,
          username:    String,
        })
      end
    end
  end
end
