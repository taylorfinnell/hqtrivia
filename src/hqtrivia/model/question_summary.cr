require "json"

module HqTrivia
  module Model
    # Sent from the server after the question is closed and the host as revealed the answer.
    class QuestionSummary
      include WebSocketMessage

      class QuestionMedia
        JSON.mapping({
          key:          String,
          media_id:     {key: "mediaId", type: String},
          type:         {key: "type", type: String},
          content_type: {key: "contentType", type: String},
        })
      end

      JSON.mapping({
        type:                     String,
        ts:                       Time,
        question_id:              {key: "questionId", type: Int32},
        question:                 String,
        answers:                  {key: "answerCounts", type: Array(Answer)},
        advancing_players_count:  {key: "advancingPlayersCount", type: Int32},
        eliminated_players_count: {key: "eliminatedPlayersCount", type: Int32},
        you_got_it_right:         {key: "youGotItRight", type: Bool},
        your_answer_id:           {key: "yourAnswerId", type: Int32},
        saved_by_extra_life:      {key: "savedByExtraLife", type: Bool},
        extra_lives_remaining:    {key: "extraLivesRemaining", type: Int32},
        question_media:           {key: "questionMedia", type: QuestionMedia?},
        c:                        Int32,
        sent:                     Time,
      })

      # Answer info about the question
      class Answer
        JSON.mapping({
          answer_id: {key: "answerId", type: Int32},
          answer:    String,
          correct:   Bool,
          count:     Int32,
        })
      end
    end
  end
end
