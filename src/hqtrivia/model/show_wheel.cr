module HqTrivia
  module Model
    # Not sure, but used in HQ Words
    class ShowWheel
      include WebSocketMessage

      JSON.mapping({
        type:     String,
        show_id:  {key: "showId", type: Int32},
        round_id: {key: "roundId", type: Int32},
        letters:  String,
        c:        Int32,
        sent:     Time,
      })

      # @letters, as an array
      def letters
        @letters.chars
      end
    end
  end
end
