require "./show_coordinator/coordinator"
require "./show_coordinator/*"

module HqTrivia
  class ShowCoordinator
    def initialize(@coordinator : Coordinator)
    end

    def on_show(blocking = true, &block : Model::Show ->)
      while show = @coordinator.current_show
        HqTrivia.logger.debug("Show: #{show.to_json}")

        if show.active
          return yield show
        elsif !blocking
          break
        else
          HqTrivia.logger.debug("#{self.class.name}: No active '#{@coordinator.country}' show")
          sleep 5
        end
      end
    end
  end
end
