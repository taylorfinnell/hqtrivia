require "json"

module HqTrivia
  module Model
    # A raw JSON message coming off the socket.
    class RawWebSocketMessage
      class JSONParseError < Exception
      end

      JSON.mapping({
        type: String,
      })

      macro decode(json)
        begin
          decoded = {{@type}}.from_json({{json}})
          case decoded.type
            {% for msg, index in Model::MessageTypes.constant("MESSAGE_LIST") %}
            when {{msg}}
              Model::{{msg.gsub(/\-/, "_").camelcase.id}}.from_json({{json}})
            {% end %}
          else
            Model::UnknownMessage.new({{json}}, Time.utc)
          end
        rescue jme : JSON::MappingError
          if jme.message =~ /Missing JSON attribute: type/
            if !HqTrivia.config.supress_missing_type_attribute_json_errors
              raise HqTrivia::Model::RawWebSocketMessage::JSONParseError.new("Could not parse '#{{{json}}}'. #{jme.message}")
            end
          elsif jme.message =~ /Missing JSON attribute/
            raise HqTrivia::Model::RawWebSocketMessage::JSONParseError.new("Could not parse '#{{{json}}}'. #{jme.message}")
          elsif jme.message =~ /was Null/
            raise HqTrivia::Model::RawWebSocketMessage::JSONParseError.new("Could not parse '#{{{json}}}'. #{jme.message}")
          end

          Model::UnknownMessage.new({{json}}, Time.utc)
        rescue jpe : JSON::ParseException
          raise HqTrivia::Model::RawWebSocketMessage::JSONParseError.new("Could not parse '#{{{json}}}'. #{jpe.message}")
        end
      end
    end
  end
end
