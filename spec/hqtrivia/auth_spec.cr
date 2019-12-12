require "../spec_helper"

module HqTrivia
  describe Auth do
    describe "headers" do
      it "can give headers for a country" do
        ENV["US_AUTHORIZATION_TOKEN"] = "token"

        auth = Auth.new
        headers = auth.headers("us")

        headers["Authorization"].should eq("Bearer token")
        headers["x-hq-device"].should be_a(String)
        headers["accept-language"].should be_a(String)
        headers["x-hq-stk"].should be_a(String)
        headers["x-hq-deviceclass"].should be_a(String)
        headers["x-hq-timezone"].should be_a(String)
        headers["x-hq-country"].should eq("us")
        headers["x-hq-lang"].should be_a(String)
        headers["Host"].should be_a(String)
        headers["Connection"].should be_a(String)
      ensure
        ENV["US_AUTHORIZATION_TOKEN"] = nil
      end

      it "can set x-hq-client and user agent" do
        ENV["US_AUTHORIZATION_TOKEN"] = "token"

        HqTrivia.config.hq_build_number = "123"
        HqTrivia.config.hq_version_number = "456"

        auth = Auth.new
        headers = auth.headers("us")

        headers["x-hq-client"].should eq("iOS/456 b123")
        headers["user-agent"].should eq("HQ-iOS/123 CFNetwork/987.0.7 Darwin/18.7.0")
      ensure
        HqTrivia.config.hq_build_number = nil
        HqTrivia.config.hq_version_number = nil
        ENV["US_AUTHORIZATION_TOKEN"] = nil
      end

      it "can set custom headers" do
        ENV["US_AUTHORIZATION_TOKEN"] = "token"

        HqTrivia.config.custom_headers = {"test" => "a"}

        auth = Auth.new
        headers = auth.headers("us")

        headers["test"].should eq("a")
      ensure
        HqTrivia.config.custom_headers = {} of String => String
        ENV["US_AUTHORIZATION_TOKEN"] = nil
      end

      it "custom headers overwrite" do
        ENV["US_AUTHORIZATION_TOKEN"] = "token"

        HqTrivia.config.custom_headers = {"x-hq-lang" => "de"}

        auth = Auth.new
        headers = auth.headers("us")

        headers["x-hq-lang"].should eq("de")
      ensure
        HqTrivia.config.custom_headers = {} of String => String
        ENV["US_AUTHORIZATION_TOKEN"] = nil
      end
    end
  end
end
