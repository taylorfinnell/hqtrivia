require "../spec_helper"

module HqTrivia
  describe Config do
    it "can configure" do
      HqTrivia.config.supress_missing_type_attribute_json_errors.should eq(false)

      HqTrivia.configure do |config|
        config.supress_missing_type_attribute_json_errors = true
      end

      HqTrivia.config.supress_missing_type_attribute_json_errors.should eq(true)
    ensure
      HqTrivia.configure do |config|
        config.supress_missing_type_attribute_json_errors = false
      end
    end

    it "defaults to supress_missing_type_attribute_json_errors being false" do
      HqTrivia.config.supress_missing_type_attribute_json_errors.should eq(false)
    end
  end
end
