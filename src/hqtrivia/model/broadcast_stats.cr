module HqTrivia
  module Model
    # Sent from the server containing various statistics about the broadcast at
    # that point in time. Used in both Trivia and Words
    class BroadcastStats
      include WebSocketMessage

      JSON.mapping({
        type:           String,
        ts:             Time,
        status_message: {key: "statusMessage", type: String},
        viewer_counts:  {key: "viewerCounts", type: ViewerCounts},
        c:              Int32,
        sent:           Time,
      })

      # Information about player counts, etc
      class ViewerCounts
        JSON.mapping({
          connected: Int32,
          playing:   Int32,
          watching:  Int32,
        })
      end
    end
  end
end
