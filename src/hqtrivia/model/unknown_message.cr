module HqTrivia
  module Model
    # A JSON message we have not yet seen, and can't decode
    class UnknownMessage
      include WebSocketMessage

      getter json, sent

      def initialize(@json : String, @sent : Time)
      end
    end
  end
end
