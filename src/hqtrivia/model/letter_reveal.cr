module HqTrivia
  module Model
    # When a letter is shown in HQ Words
    class LetterReveal
      include WebSocketMessage

      JSON.mapping({
        type:         String,
        ts:           Time,
        show_id:      {key: "showId", type: Int32},
        round_id:     {key: "roundId", type: Int32},
        puzzle_state: {key: "puzzleState", type: Array(String)},
        reveal:       String,
        c:            Int32,
        sent:         Time,
      })
    end
  end
end
