module HqTrivia
  module Model
    class HeartPhotoUpload
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        ts:       Time,
        c:        Int32,
        sent:     Time,
        show_id:  {type: Int32, key: "showId"},
        scene_id: {type: String, key: "sceneId"},
        category: String,
        round:    Int32,
      })
    end
  end
end
