module HqTrivia
  module Model
    # For coercing string ints to actual ints
    class IntCoerce
      # Attempts to coerce a string int, ie "123" into an actual int. Works
      # even if it already is an Int32
      def self.from_json(json : JSON::PullParser)
        if val = json.read?(Int32)
          val
        else
          json.read_string.to_i
        end
      end

      # Converts an Int32 back to a string
      def self.to_json(value, builder)
        builder.string value.to_s
      end
    end
  end
end
