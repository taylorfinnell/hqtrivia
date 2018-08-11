require "./spec_helper"

describe HqTrivia do
  it "yields active shows" do
    coordinator = HqTrivia::LocalCoordinator.new("us", active: true)

    HqTrivia.on_show(coordinator) do |show|
      show.should be_a(HqTrivia::Model::Show)
    end
  end

  it "does not yield inactive shows" do
    coordinator = HqTrivia::LocalCoordinator.new("us", active: false)

    HqTrivia.on_show(coordinator, blocking: false) do |show|
      raise "should not have yielded"
    end
  end
end
