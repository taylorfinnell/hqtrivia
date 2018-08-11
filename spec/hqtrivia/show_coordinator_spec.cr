require "../../spec_helper"

module HqTrivia
  describe ShowCoordinator do
    it "yields the show if it is active" do
      coordinator = LocalCoordinator.new("us", active: true)
      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show do |show|
        show.should be_a(Model::Show)
      end
    end

    it "does not yield the show if it is inactive" do
      coordinator = LocalCoordinator.new("us", active: false)
      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show(blocking: false) do |show|
        raise "bad"
      end
    end
  end
end
