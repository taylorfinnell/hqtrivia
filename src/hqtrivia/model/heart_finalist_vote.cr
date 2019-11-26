module HqTrivia
  module Model
    class HeartFinalistVote
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        ts:       Time,
        c:        Int32,
        sent:     Time,
        category: String,
        round:    Int32,
        stack:    Array(Photo),
      })
    end
  end
end
