module HqTrivia
  class LocalCoordinator < Coordinator
    def initialize(@country : String, @active = false)
    end

    def current_show
      Model::Show.new(active: @active, show_id: 123,
        start_time: Time.utc_now, prize: 666, show_type: "hq-us")
    end
  end
end
