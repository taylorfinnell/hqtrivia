require "../spec_helper"

module HqTrivia
  describe ShowCoordinator do
    it "yields if show is active and no game type is set" do
      coordinator = LocalCoordinator.new("us")
      coordinator.show = Model::Show.new(active: true, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show do |show|
        show.should be_a(Model::Show)
      end
    end

    it "yields if show is active and game type matches trivia" do
      coordinator = LocalCoordinator.new("us", game_type: "trivia")
      coordinator.show = Model::Show.new(active: true, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us", game_type: "trivia")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show do |show|
        show.should be_a(Model::Show)
      end
    end

    it "yields if show is active and game type matches words" do
      coordinator = LocalCoordinator.new("us", game_type: "words")
      coordinator.show = Model::Show.new(active: true, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us", game_type: "words")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show do |show|
        show.should be_a(Model::Show)
      end
    end

    it "does not yield if game_type does not match" do
      coordinator = LocalCoordinator.new("us", game_type: "trivia")
      coordinator.show = Model::Show.new(active: true, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us", game_type: "words")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show(blocking: false) do |show|
        raise "bad"
      end
    end

    it "yields the show if it is active" do
      coordinator = LocalCoordinator.new("us")
      coordinator.show = Model::Show.new(active: true, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us", game_type: "words")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show(blocking: false) do |show|
        show.should be_a(Model::Show)
      end
    end

    it "does not yield the show if it is inactive" do
      coordinator = LocalCoordinator.new("us")
      coordinator.show = Model::Show.new(active: false, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us", game_type: "words")

      show_coord = ShowCoordinator.new(coordinator)
      show_coord.on_show(blocking: false) do |show|
        raise "bad"
      end
    end
  end
end
