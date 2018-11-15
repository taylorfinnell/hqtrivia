module HqTrivia
  abstract class Coordinator
    getter country
    getter game_type

    def initialize(@country : String, @game_type : String? = nil)
    end

    abstract def current_show
  end
end
