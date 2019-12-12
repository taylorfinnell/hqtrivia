module HqTrivia
  class Config
    property supress_missing_type_attribute_json_errors
    property hq_version_number
    property hq_build_number
    property custom_headers

    def initialize(@hq_version_number : String? = nil, @hq_build_number : String? = nil,
                   @supress_missing_type_attribute_json_errors = false, @custom_headers = {} of String => String)
    end
  end
end
