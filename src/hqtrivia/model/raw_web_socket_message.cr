require "json"

module HqTrivia
  module Model
    # A raw JSON message coming off the socket.
    class RawWebSocketMessage
      JSON.mapping({
        type: String,
      })

      def self.decode(json)
        msg = from_json(json)
        case msg.type
        when "broadcastEnded"
          BroadcastEnded.from_json(json)
        when "broadcastStats"
          BroadcastStats.from_json(json)
        when "gameSummary"
          GameSummary.from_json(json)
        when "interaction"
          Interaction.from_json(json)
        when "postGame"
          PostGame.from_json(json)
        when "question"
          Question.from_json(json)
        when "questionClosed"
          QuestionClosed.from_json(json)
        when "questionFinished"
          QuestionFinished.from_json(json)
        when "questionSummary"
          QuestionSummary.from_json(json)
        else
          UnknownMessage.new(json)
        end
      end
    end
  end
end
