module HqTrivia
  module Model
    # A JSON message we have not yet seen, and can't decode
    class UnknownMessage
      include WebSocketMessage

      getter json

      def initialize(@json : String)
      end
    end
  end
end
