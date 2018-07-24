module HqTrivia
  abstract class Coordinator
    getter country

    def initialize(@country : String)
    end

    abstract def current_show
  end
end
