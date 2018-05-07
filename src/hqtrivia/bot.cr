require "./model/message_types"

module HqTrivia
  # The HqTrivia bot, given a connection it has call backs for messages received
  module Bot
    @show : HqTrivia::Model::Show?

    def play(connection = Connection::Hq.new, blocking = true, record_network = false)
      connection.on_show do |show|
        @show = show
      end

      connection.on_message do |message|
        handle_message(message)
      end

      connection.on_raw_message do |json|
        handle_message(json)
      end

      connection.connect(blocking, record_network)
    end

    # The start time of the current show, nil if no show is going
    def start_time
      @show.try &.start_time
    end

    # The id of the current show, nil if no show is going
    def show_id
      @show.try &.show_id
    end

    # The prize of the current show, nil if no show is going
    def prize
      @show.try &.prize
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
