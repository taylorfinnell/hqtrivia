require "json"

module HqTrivia
  module Model
    # The JSON response from hitting the 'https://api-quiz.hype.space/shows/now?type=hq' endpoint.
    class Show
      JSON.mapping({
        active:     Bool,
        show_id:    {type: Int32?, key: "showId"},
        start_time: {type: Time?, key: "startTime"},
        broadcast:  Broadcast?,
        prize:      Int32?,
        show_type:  {type: String?, key: "showType"},
        game_type:  {type: String?, key: "gameType"},
      })

      def initialize(@active : Bool, @show_id : Int32?, @start_time : Time?,
                     @prize : Int32, @show_type : String?, @game_type : String? = nil)
      end

      def socket_url
        raise "Show not active" unless @active

        @broadcast.try &.socket_url
      end
    end

    class Broadcast
      JSON.mapping({
        socket_url: {type: String, key: "socketUrl"},
      })
    end
  end
end
