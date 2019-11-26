module HqTrivia
  module Model
    class HeartPhotoVote
      include WebSocketMessage

      JSON.mapping({
        type:             String,
        ts:               Time,
        c:                Int32,
        sent:             Time,
        round:            Int32,
        category:         String,
        submission_count: {type: Int32, key: "submissionCount"},
        stack:            Array(Photo),
      })
    end
  end
end
