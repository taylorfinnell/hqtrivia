module HqTrivia
  module Model
    # Represents a round start in HQ Words
    class StartRound
      include WebSocketMessage

      JSON.mapping({
        type:                     String,
        show_id:                  {key: "showId", type: Int32},
        round_id:                 {key: "roundId", type: Int32},
        total_rounds:             {key: "totalRounds", type: Int32},
        puzzle_id:                {key: "puzzleId", type: Int32?},
        round_number:             {key: "roundNumber", type: Int32},
        hint:                     String,
        puzzle_state:             {key: "puzzleState", type: Array(String)},
        time_left_ms:             {key: "timeLeftMs", type: Int32},
        total_time_ms:            {key: "totalTimeMs", type: Int32},
        initial_revealed_letters: {key: "initialRevealedLetters", type: Array(String)},
        free_letters:             {key: "freeLetters", type: Array(String)},
        c:                        Int32,
        sent:                     Time,
      })
    end
  end
end
