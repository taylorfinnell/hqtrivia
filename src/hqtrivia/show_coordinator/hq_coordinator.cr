module HqTrivia
  class HqCoordinator < Coordinator
    class HttpException < Exception
    end

    class NotAuthenticatedError < Exception
    end

    def current_show
      connection_failed = ->(ex : Exception) do
        HqTrivia.logger.debug("#{self.class.name}: Connection to HQ (#{@country}) server failed...retrying. #{ex}")
      end

      retryable(on: HttpException | Socket::Error, tries: 5, wait: 1, callback: connection_failed) do
        resp = HTTP::Client.get("https://api-quiz.hype.space/shows/now?type=hq", headers: HqTrivia.auth.header(@country))

        if (200..299).includes?(resp.status_code)
          Model::Show.from_json(resp.body)
        elsif resp.status_code == 401
          raise NotAuthenticatedError.new("Could not authenticate #{@country}, the token is probably expired")
        else
          raise HttpException.new("#{resp.body} (#{resp.status_code}) (country: #{@country})")
        end
      end
    end
  end
end
