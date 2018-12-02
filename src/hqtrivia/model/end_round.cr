module HqTrivia
  module Model
    # Represents a round end in HQ Words
    class EndRound
      include WebSocketMessage

      JSON.mapping({
        type:              String,
        ts:                Time,
        answer:            Array(String),
        hint:              String,
        show_id:           {key: "showId", type: Int32},
        round_id:          {key: "roundId", type: Int32},
        round_number:      {key: "roundNumber", type: Int32},
        round_duration_ms: {key: "roundDurationMs", type: Int32},
        correct_answers:   {key: "correctAnswers", type: Int32},
        incorrect_answers: {key: "incorrectAnswers", type: Int32},
        c:                 Int32,
        sent:              Time,
      })
    end
  end
end
