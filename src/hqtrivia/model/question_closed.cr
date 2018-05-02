require "json"

module HqTrivia
  module Model
    # Sent from the server when the timelimit as run out on a question.
    class QuestionClosed
      include WebSocketMessage

      JSON.mapping({
        type:        String,
        ts:          String,
        question_id: {key: "questionId", type: String},
        c:           Int32,
        sent:        String,
      })
    end
  end
end
