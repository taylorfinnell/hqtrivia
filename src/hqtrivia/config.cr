module HqTrivia
  class Config
    property supress_missing_type_attribute_json_errors

    def initialize(@supress_missing_type_attribute_json_errors = false)
    end
  end
end
