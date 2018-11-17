require "./show_coordinator/coordinator"
require "./show_coordinator/*"

module HqTrivia
  # Coordinates shows, continues to ping HQ looking for shows.
  class ShowCoordinator
    def initialize(@coordinator : Coordinator)
    end

    # When an active show is found it is yielded to the block, by defaults it blocks the thread
    def on_show(blocking = true, &block : Model::Show ->)
      while show = @coordinator.current_show
        HqTrivia.logger.debug("Show: #{show.to_json}")

        if show.active && (@coordinator.game_type.nil? || @coordinator.game_type == show.game_type)
          return yield show
        elsif !blocking
          break
        else
          HqTrivia.logger.debug("#{self.class.name}: No active '#{@coordinator.country}' show")
          wait
        end
      end
    end

    # :nodoc:
    private def wait
      sleep sleep_time
    end

    # :nodoc:
    private def sleep_time
      (ENV["HQ_SHOW_COORDINATOR_SLEEP_TIME"]? || 1.minute).to_i
    end
  end
end
