module HqTrivia
  # Searches for shows against the actual HQ API
  class HqCoordinator < Coordinator
    # Raised when HTTP error happens
    class HttpException < Exception
    end

    # Raised when token is invalid
    class NotAuthenticatedError < Exception
    end

    # Current HQ show, or nil
    def current_show
      connection_failed = ->(ex : Exception) do
        HqTrivia.logger.debug("#{self.class.name}: Connection to HQ (#{@country}) server failed...retrying. #{ex}")
      end

      retryable(on: HttpException | Socket::Error, tries: 5, wait: 1, callback: connection_failed) do
        resp = HTTP::Client.get("https://api-quiz.hype.space/shows/now?type=#{final_game_type}", headers: HqTrivia.auth.header(@country))

        HqTrivia.logger.debug("#{self.class.name} http response for #{@country}: #{resp.body}")

        if (200..299).includes?(resp.status_code)
          Model::Show.from_json(resp.body)
        elsif resp.status_code == 401
          raise NotAuthenticatedError.new("Could not authenticate #{@country}, the token is probably expired")
        else
          raise HttpException.new("#{resp.body} (#{resp.status_code}) (country: #{@country})")
        end
      end
    end

    private def final_game_type
      case @game_type
      when nil, "trivia"
        "hq"
      when "words"
        "hq-words"
      else
        raise "Invalid game type: #{@game_type}"
      end
    end
  end
end
