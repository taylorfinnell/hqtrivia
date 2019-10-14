require "json"

module HqTrivia
  module Model
    # The JSON response from hitting the 'https://api-quiz.hype.space/shows/now?type=hq' endpoint.
    class Show
      class Media
        JSON.mapping({
          media_id:  {type: String, key: "mediaId"},
          media_url: {type: String, key: "mediaUrl"},
          hash:      {type: String, key: "hash"},
          size:      {type: Int64, key: "size"},
        })
      end

      JSON.mapping({
        active:     Bool,
        show_id:    {type: Int32?, key: "showId"},
        start_time: {type: Time?, key: "startTime"},
        broadcast:  Broadcast?,
        prize:      Int32?,
        show_type:  {type: String?, key: "showType"},
        game_type:  {type: String?, key: "gameType"},
        media:      {type: Array(Media)?},
      })

      def initialize(@active : Bool, @show_id : Int32?, @start_time : Time?,
                     @prize : Int32, @show_type : String?, @game_type : String? = nil)
      end

      # Socket url if show is active, raises if show is not active
      def socket_url
        raise "Show not active" unless @active

        @broadcast.try &.socket_url
      end
    end

    # Broadcast information for a show
    class Broadcast
      JSON.mapping({
        socket_url:   {type: String, key: "socketUrl"},
        broadcast_id: {type: Int32, key: "broadcastId"},
      })
    end
  end
end
