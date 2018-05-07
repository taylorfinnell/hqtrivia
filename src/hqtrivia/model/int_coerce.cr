module HqTrivia
  module Model
    class IntCoerce
      def self.from_json(json : JSON::PullParser)
        json.read_string.to_i
      end
    end
  end
end
