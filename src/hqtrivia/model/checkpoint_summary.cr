module HqTrivia
  module Model
    class CheckpointSummary
      include WebSocketMessage

      JSON.mapping({
        type:          String,
        ts:            Time,
        num_winners:   {key: "numWinners", type: Int32},
        players_left:  {key: "playersRemaining", type: Int32},
        prize_offered: {key: "prizeOffered", type: String},
        checkpoint_id: {key: "checkpointId", type: String},
        c:             Int32,
        sent:          Time,
      })
    end
  end
end
