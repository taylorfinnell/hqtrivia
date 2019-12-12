module HqTrivia
  module Model
    class Photo
      class PhotoMeta
        JSON.mapping({
          scene_id: {type: String, key: "sceneId"},
          user_id:  {type: Int32, key: "userId"},
        })
      end

      JSON.mapping({
        photo_url:  {type: String, key: "photoUrl"},
        survey_key: {type: String, key: "surveyKey"},
      })

      def scene_id
        meta.scene_id
      end

      def user_id
        meta.user_id
      end

      private def meta
        b64 = survey_key.to_s.split(".")[1]
        dec = Base64.decode_string(b64)
        PhotoMeta.from_json(dec)
      end
    end
  end
end
