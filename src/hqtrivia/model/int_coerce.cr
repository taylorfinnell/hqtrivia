module HqTrivia
  module Model
    class IntCoerce
      def self.from_json(json : JSON::PullParser)
        if val = json.read?(Int32)
          val
        else
          json.read_string.to_i
        end
      end

      def self.to_json(value, builder)
        builder.string value.to_s
      end
    end
  end
end
