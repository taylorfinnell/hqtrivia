module HqTrivia
  class Auth
    def header(country : String)
      HTTP::Headers{"Authorization" => "Bearer #{token(country)}"}
    end

    private def token(country : String)
      ENV["#{country.upcase}_AUTHORIZATION_TOKEN"]
    end
  end
end
