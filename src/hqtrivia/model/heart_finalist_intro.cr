module HqTrivia
  module Model
    class HeartFinalistIntro
      include WebSocketMessage

      JSON.mapping({
        type:      String,
        ts:        Time,
        c:         Int32,
        sent:      Time,
        finalists: Array(Finalist),
      })
    end
  end
end
