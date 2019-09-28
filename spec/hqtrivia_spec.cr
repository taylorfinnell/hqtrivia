require "./spec_helper"

describe HqTrivia do
  it "yields active shows" do
    coordinator = HqTrivia::LocalCoordinator.new("us")
    coordinator.show = HqTrivia::Model::Show.new(active: true, show_id: 123,
      start_time: Time.utc, prize: 666, show_type: "hq-us", game_type: "trivia")

    HqTrivia.on_show(coordinator) do |show|
      show.should be_a(HqTrivia::Model::Show)
    end
  end

  it "does not yield inactive shows" do
    coordinator = HqTrivia::LocalCoordinator.new("us")
    coordinator.show = HqTrivia::Model::Show.new(active: false, show_id: 123,
      start_time: Time.utc, prize: 666, show_type: "hq-us", game_type: "trivia")

    HqTrivia.on_show(coordinator, blocking: false) do |show|
      raise "should not have yielded"
    end
  end
end
