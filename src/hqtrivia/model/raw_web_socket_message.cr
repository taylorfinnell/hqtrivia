require "json"

module HqTrivia
  module Model
    # A raw JSON message coming off the socket.
    class RawWebSocketMessage
      JSON.mapping({
        type: String,
      })

      macro decode(json)
        decoded = {{@type}}.from_json({{json}})
        case decoded.type
        {% for msg, index in Model::MessageTypes.constant("MESSAGE_LIST") %}
        when {{msg}}
          Model::{{msg.camelcase.id}}.from_json({{json}})
        {% end %}
        else
          Model::UnknownMessage.new({{json}}, Time.utc_now)
        end
      end
    end
  end
end
