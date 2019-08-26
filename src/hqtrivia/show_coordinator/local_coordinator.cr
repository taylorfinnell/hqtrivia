module HqTrivia
  # A fake coordinator used for testing, etc
  class LocalCoordinator < Coordinator
    @show : Model::Show?

    # Show to be returned by local fake coordinator
    property show

    # Show to be returned by local fake coordinator, or an inactive show
    def current_show
      @show || no_show
    end

    private def no_show
      Model::Show.new(active: false, show_id: nil, start_time: nil, prize: 0,
        show_type: nil, game_type: nil)
    end
  end
end
