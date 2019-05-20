module HqTrivia
  module Model
    class SurveyResults
      include WebSocketMessage

      class Result
        JSON.mapping({
          display_count:    {type: String, key: "displayCount"},
          survey_answer_id: {type: String, key: "surveyAnswerId"},
          display_text:     {type: String, key: "displayText"},
          vote_count:       {type: Int32, key: "voteCount"},
        })
      end

      JSON.mapping({
        type:               String,
        ts:                 Time,
        question:           String,
        survey_question_id: {key: "surveyQuestionId", type: String},
        results:            Array(SurveyResults::Result),
        vote_count:         {key: "voteCount", type: Int32},
        c:                  Int32,
        sent:               Time,
      })
    end
  end
end
