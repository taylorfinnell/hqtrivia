module HqTrivia
  module Model
    class SurveyQuestion
      include WebSocketMessage

      class Answer
        JSON.mapping({
          survey_answer_id: {type: String, key: "surveyAnswerId"},
          display_text:     {type: String, key: "displayText"},
        })
      end

      JSON.mapping({
        type:               String,
        ts:                 Time,
        question:           String,
        survey_question_id: {key: "surveyQuestionId", type: String},
        answers:            Array(SurveyQuestion::Answer),
        c:                  Int32,
        sent:               Time,
      })
    end
  end
end
