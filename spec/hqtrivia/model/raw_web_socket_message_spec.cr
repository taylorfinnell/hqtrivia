require "../../spec_helper"

module HqTrivia::Model
  describe RawWebSocketMessage do
    it "raises if if type is missing in thhe json and supress_missing_type_attribute_json_errors is false" do
      json = {"blah" => 1}.to_json

      expect_raises(JSON::MappingError, /Missing JSON attribute: type/) do
        RawWebSocketMessage.decode(json)
      end
    end

    it "gives an unknown message if type is missing from json and supress_missing_type_attribute_json_errors is true" do
      json = {"blah" => 1}.to_json

      HqTrivia.configure do |config|
        config.supress_missing_type_attribute_json_errors = true
      end

      msg = RawWebSocketMessage.decode(json)

      msg.is_a?(Model::UnknownMessage).should eq(true)
      msg.as(Model::UnknownMessage).json.should eq("{\"blah\":1}")
    ensure
      HqTrivia.configure do |config|
        config.supress_missing_type_attribute_json_errors = false
      end
    end
  end
end
