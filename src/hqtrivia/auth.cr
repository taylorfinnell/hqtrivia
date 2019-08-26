module HqTrivia
  # Manages bearer tokens for various countries
  class Auth
    # Given a *country* it returns the bearer token from the ENV
    def token(country : String)
      ENV["#{country.upcase}_AUTHORIZATION_TOKEN"]
    end

    # Given a *country* it returns the required headers
    def headers(country)
      HTTP::Headers{
        "Authorization"    => "Bearer #{token(country)}",
        "x-hq-device"      => "iPhone10,4",
        "x-hq-client"      => "iOS/1.5.1 b157",
        "accept-language"  => "en-us",
        "x-hq-stk"         => "MQ==",
        "x-hq-deviceclass" => "phone",
        "x-hq-timezone"    => "America/Chicago",
        "user-agent"       => "HQ-iOS/157 CFNetwork/987.0.7 Darwin/18.7.0",
        "x-hq-country"     => country,
        "x-hq-lang"        => "en",
        "Host"             => "api-quiz.hype.space",
        "Connection"       => "Keep-Alive",
        # "Accept-Encoding"  => "gzip",
      }
    end
  end
end
