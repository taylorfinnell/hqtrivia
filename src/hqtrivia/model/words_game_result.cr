module HqTrivia
  module Model
    # Results of an HQ Words game
    class WordsGameResult
      include WebSocketMessage

      JSON.mapping({
        type:        String,
        show_id:     {key: "showId", type: Int32},
        winners:     Array(Winner),
        num_winners: {key: "numWinners", type: Int32?},
        c:           Int32,
        sent:        Time,
      })

      # Winner information
      class Winner
        JSON.mapping({
          winner: User,
          rank:   Int32,
          prize:  String,
          time:   Int32,
        })

        # User information
        class User
          JSON.mapping({
            username:   String,
            user_id:    {key: "userId", type: Int32},
            avatar_url: {key: "avatarUrl", type: String},
            points:     Int32,
          })
        end
      end
    end
  end
end
