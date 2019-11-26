module HqTrivia
  # Manages bearer tokens for various countries
  class Auth
    # Given a *country* it returns the bearer token from the ENV
    def token(country : String)
      ENV["#{country.upcase}_AUTHORIZATION_TOKEN"]
    end

    # Given a *country* it returns the required headers
    def headers(country)
      headers = HTTP::Headers{
        "Authorization"    => "Bearer #{token(country)}",
        "x-hq-device"      => "iPhone10,4",
        "accept-language"  => "en-us",
        "x-hq-stk"         => "MQ==",
        "x-hq-deviceclass" => "phone",
        "x-hq-timezone"    => "America/Chicago",
        "x-hq-country"     => country,
        "x-hq-lang"        => "en",
        "Host"             => "api-quiz.hype.space",
        "Connection"       => "Keep-Alive",
        # "Accept-Encoding"  => "gzip",
      }

      if build_number && version_number
        headers.merge!({
          "x-hq-client" => "iOS/#{version_number} b#{build_number}",
          "user-agent"  => "HQ-iOS/#{build_number} CFNetwork/987.0.7 Darwin/18.7.0",
        })
      end

      unless custom_headers.empty?
        headers.merge!(custom_headers)
      end

      headers
    end

    private def custom_headers
      HqTrivia.config.custom_headers
    end

    private def build_number
      HqTrivia.config.hq_build_number
    end

    private def version_number
      HqTrivia.config.hq_version_number
    end
  end
end
