module HqTrivia
  class LocalCoordinator < Coordinator
    @show : Model::Show?

    property show

    def current_show
      @show
    end
  end
end
