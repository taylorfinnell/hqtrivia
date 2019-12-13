module HqTrivia
  module Model
    class HeartFinalistWalkthrough
      include WebSocketMessage

      JSON.mapping({
        type:      String,
        ts:        Time,
        c:         Int32,
        sent:      Time,
        category:  String,
        photo_url: {type: String?, key: "photoUrl"},
        finalist:  {type: UserProfile, key: "finalistProfile"},
      })
    end
  end
end
