require "./int_coerce"
require "json"

module HqTrivia
  module Model
    # Sent from the server when the timelimit as run out on a question.
    class QuestionClosed
      include WebSocketMessage

      JSON.mapping({
        type:        String,
        ts:          Time,
        question_id: {key: "questionId", type: Int32, converter: IntCoerce},
        round_id:    {key: "roundId", type: Int32?, converter: IntCoerce},
        c:           Int32,
        sent:        Time,
      })
    end
  end
end
