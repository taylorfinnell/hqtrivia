require "json"

module HqTrivia
  module Model
    # Sent from the server when the client receives a new question.
    class Question
      include WebSocketMessage

      JSON.mapping({
        type:            String,
        ts:              String,
        total_time_ms:   {key: "totalTimeMs", type: Int32},
        time_left_ms:    {key: "timeLeftMs", type: Int32},
        question_id:     {key: "questionId", type: Int32},
        question:        String,
        category:        String,
        answers:         Array(Answer),
        question_number: {key: "questionNumber", type: Int32},
        question_count:  {key: "questionCount", type: Int32},
        ask_time:        {key: "askTime", type: String},
        c:               Int32,
        sent:            String,
      })

      class Answer
        JSON.mapping({
          answer_id: {key: "answerId", type: Int32},
          text:      String,
        })
      end
    end
  end
end
