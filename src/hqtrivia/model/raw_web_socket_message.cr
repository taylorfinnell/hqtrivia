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
            Model::UnknownMessage.new({{json}}, Time.utc)
          end
        rescue jme : JSON::MappingError
          if jme.message =~ /Missing JSON attribute: type/ && HqTrivia.config.supress_missing_type_attribute_json_errors
            Model::UnknownMessage.new({{json}}, Time.utc)
          else
            HqTrivia.logger.error("Failed to parse json: #{{{json}}}")
            raise jme
          end
        end
      end
    end
  end
end
