require "json"

module HqTrivia
  module Model
    # A raw JSON message coming off the socket.
    class RawWebSocketMessage
      JSON.mapping({
        type: String,
      })

      macro decode(json)
        begin
          decoded = {{@type}}.from_json({{json}})
          case decoded.type
          {% for msg, index in Model::MessageTypes.constant("MESSAGE_LIST") %}
          when {{msg}}
            Model::{{msg.camelcase.id}}.from_json({{json}})
          {% end %}
          else
            Model::UnknownMessage.new({{json}}, Time.utc_now)
          end
        rescue jme : JSON::MappingError
          HqTrivia.logger.error("Failed to parse json: #{{{json}}}")
          raise jme
        end
      end
    end
  end
end
