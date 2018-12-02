module HqTrivia
  # A fake coordinator used for testing, etc
  class LocalCoordinator < Coordinator
    @show : Model::Show?

    # Show to be returned by local fake coordinator
    property show

    # Show to be returned by local fake coordinator, or nil
    def current_show
      @show
    end
  end
end
