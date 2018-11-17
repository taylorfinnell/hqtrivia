module HqTrivia
  # Abstract class for coordinating shows
  abstract class Coordinator
    # Country for the show
    getter country

    # Type of game, "trivia" or "words"
    getter game_type

    def initialize(@country : String, @game_type : String? = nil)
    end

    # The current show, or nil
    abstract def current_show
  end
end
