module HqTrivia
  module Model
    # Not sure, but used in HQ Words
    class HideWheel
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        ts:       Time,
        show_id:  {key: "showId", type: Int32},
        round_id: {key: "roundId", type: Int32},
        c:        Int32,
        sent:     Time,
      })
    end
  end
end
