module HqTrivia
  module Model
    class Checkpoint
      include WebSocketMessage

      JSON.mapping({
        type:                String,
        ts:                  Time,
        checkpoint_id:       {key: "checkpointId", type: String},
        is_final_checkpoint: {key: "isFinalCheckpoint", type: Bool},
        question_number:     {key: "questionNumber", type: Int32},
        prize_offered:       {key: "prizeOffered", type: String},
        c:                   Int32,
        sent:                Time,
      })
    end
  end
end
