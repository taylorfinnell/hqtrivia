module HqTrivia
  module Model
    class UserProfile
      JSON.mapping({
        user_id:          {type: Int32, key: "userId"},
        name:             String,
        instagram_handle: {type: String?, key: "instagramHandle"},
      })
    end

    class Finalist
      JSON.mapping({
        rank:    Int32,
        profile: {key: "userProfile", type: UserProfile},
      })
    end
  end
end
