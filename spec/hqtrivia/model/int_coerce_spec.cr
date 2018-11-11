require "../../spec_helper"

module HqTrivia::Model
  describe IntCoerce do
    describe "from_json" do
      it "works with strings" do
        pull = JSON::PullParser.new("\"1\"")
        IntCoerce.from_json(pull).should eq(1)
      end

      it "works with ints" do
        pull = JSON::PullParser.new("1")
        IntCoerce.from_json(pull).should eq(1)
      end
    end
  end
end
