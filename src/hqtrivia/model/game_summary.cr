module HqTrivia
  module Model
    # Sent from the server containing information about the game, once it has
    # ended. Including winner information.
    class GameSummary
      include WebSocketMessage

      JSON.mapping({
        type:        String,
        ts:          Time,
        show_id:     {key: "showId", type: Int32},
        winners:     Array(Winner),
        num_winners: {key: "numWinners", type: Int32},
        you_won:     {key: "youWon", type: Bool},
        c:           Int32,
        sent:        Time,
      })

      # Winner information
      class Winner
        JSON.mapping({
          name:       String,
          id:         Int32,
          avatar_url: {key: "avatarUrl", type: String},
          prize:      String,
          wins:       Int32,
        })
      end
    end
  end
end
