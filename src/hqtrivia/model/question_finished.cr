require "json"

module HqTrivia
  module Model
    # Sent from the server when the question is fully done, this is the last
    # message sent pertaining to a question.
    class QuestionFinished
      include WebSocketMessage

      JSON.mapping({
        type:        String,
        ts:          Time,
        question_id: {key: "questionId", type: Int32, converter: IntCoerce},
        c:           Int32,
        sent:        Time,
      })
    end
  end
end
