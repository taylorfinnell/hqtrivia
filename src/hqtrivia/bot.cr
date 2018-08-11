require "./model/message_types"

module HqTrivia
  # The HqTrivia bot, given a connection it has call backs for messages received
  module Bot
    def initialize(@show : HqTrivia::Model::Show, @coordinator : Coordinator)
    end

    def play(connection = HqTrivia::Connection::Hq.new)
      HqTrivia.logger.debug("Bot playing #{@coordinator.country} show #{@show.to_json}")

      connection.on_message do |message|
        handle_message(message)
      end

      connection.on_raw_message do |json|
        handle_message(json)
      end

      connection.connect(@show, @coordinator)
    end

    # The start time of the current show, nil if no show is going
    def start_time
      @show.start_time
    end

    # The id of the current show, nil if no show is going
    def show_id
      @show.show_id
    end

    # The prize of the current show, nil if no show is going
    def prize
      @show.prize
    end

    def country
      @coordinator.country
    end

    {% for msg, index in Model::MessageTypes.constant("MESSAGE_LIST") %}
      protected def handle_message(message : Model::{{msg.camelcase.id}})
      end
    {% end %}

    protected def handle_message(message : Model::UnknownMessage)
    end

    protected def handle_message(message : String)
    end
  end
end
