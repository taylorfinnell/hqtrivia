module HqTrivia
  module Model
    # Sent from the server containing various statistics about the broadcast at
    # that point in time.
    class BroadcastStats
      include WebSocketMessage

      JSON.mapping({
        type:           String,
        ts:             String,
        status_message: {key: "statusMessage", type: String},
        viewer_counts:  {key: "viewerCounts", type: ViewerCounts},
        c:              Int32,
        sent:           String,
      })

      # :nodoc:
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
