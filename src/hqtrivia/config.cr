module HqTrivia
  class Config
    property supress_missing_type_attribute_json_errors
    property hq_version_number
    property hq_build_number

    def initialize(@hq_version_number : String? = nil, @hq_build_number : String? = nil, @supress_missing_type_attribute_json_errors = false)
    end
  end
end
