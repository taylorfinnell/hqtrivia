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
          wait
        end
      end
    end

    private def wait
      sleep sleep_time
    end

    private def sleep_time
      (ENV["HQ_SHOW_COORDINATOR_SLEEP_TIME"]? || 1.minute).to_i
    end
  end
end
