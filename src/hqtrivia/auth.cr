module HqTrivia
  # Manages bearer tokens for various countries
  class Auth
    # Given a *country* it returns the bearer token from the ENV
    def header(country : String)
      HTTP::Headers{
        "Authorization"    => "Bearer #{token(country)}",
        "x-hq-device"      => "iPhone10,4",
        "x-hq-client"      => "iOS/1.3.27 b121",
        "accept-language"  => "en-us",
        "x-hq-stk"         => "MQ==",
        "x-hq-deviceclass" => "phone",
        "x-hq-timezone"    => "America/Chicago",
        "user-agent"       => "HQ-iOS/121 CFNetwork/975.0.3 Darwin/18.2.0",
        "x-hq-country"     => "us",
        "x-hq-lang"        => "en",
      }
    end

    # :nodoc:
    private def token(country : String)
      ENV["#{country.upcase}_AUTHORIZATION_TOKEN"]
    end
  end
end
