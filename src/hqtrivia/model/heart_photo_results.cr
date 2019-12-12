module HqTrivia
  module Model
    class HeartPhotoResults
      include WebSocketMessage

      class Results
        JSON.mapping({
          likes: {type: Int32, key: "yay"},
        })
      end

      JSON.mapping({
        type:         String,
        ts:           Time,
        c:            Int32,
        sent:         Time,
        round:        Int32,
        category:     String,
        results_type: {type: String, key: "resultsType"},
        winner:       {type: UserProfile?, key: "userProfile"},
        results:      Results?,
        photo_url:    {type: String?, key: "photoUrl"},
      })
    end
  end
end
