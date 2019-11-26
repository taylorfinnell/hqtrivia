module HqTrivia
  module Model
    class HeartEpisodeWinners
      include WebSocketMessage

      class Winner
        JSON.mapping({
          rank:    Int32,
          likes:   {type: Int32, key: "yay"},
          photos:  {type: Array(String), key: "photoUrls"},
          profile: {type: UserProfile, key: "userProfile"},
        })
      end

      JSON.mapping({
        type:    String,
        ts:      Time,
        c:       Int32,
        sent:    Time,
        winners: Array(Winner),
      })
    end
  end
end
