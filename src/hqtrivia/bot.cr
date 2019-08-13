require "./model/message_types"

module HqTrivia
  # The HqTrivia bot, given a connection it has call backs for messages received
  module Bot
    @connection : HqTrivia::Connection::Interface?

    @show : Model::Show

    def initialize(@coordinator : Coordinator)
      @show = @coordinator.current_show
    end

    # Play the game on the given *connection*
    def play(connection : HqTrivia::Connection::Interface)
      HqTrivia.logger.debug("Bot playing #{@coordinator.country} show #{@show.to_json}")

      @connection = connection

      @connection.not_nil!.on_message do |message|
        handle_message(message)
      end

      @connection.not_nil!.on_raw_message do |json|
        handle_message(json)
      end

      @connection.not_nil!.on_client_ping do |message|
        on_client_ping(message)
      end

      @connection.not_nil!.on_server_pong do |message|
        on_server_pong(message)
      end

      @connection.not_nil!.connect(@coordinator)

      @connection.not_nil!.run
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

    # The type of game, currently "trivia" or "words"
    def game_type
      @coordinator.game_type
    end

    # The country that is playing this game
    def country
      @coordinator.country
    end

    private def send_message(message : String)
      @connection.not_nil!.send_message(message)
    end

    protected def on_client_ping(message : String)
      HqTrivia.logger.debug("Client sent PING with '#{message}'")
    end

    protected def on_server_pong(message : String)
      HqTrivia.logger.debug("Server sent PONG with '#{message}'")
    end

    {% for msg, index in Model::MessageTypes.constant("MESSAGE_LIST") %}
      protected def handle_message(message : Model::{{msg.camelcase.id}})
      end
    {% end %}

    # Called when an unknown message is seen
    protected def handle_message(message : Model::UnknownMessage)
    end

    # Called with raw JSON
    protected def handle_message(message : String)
    end
  end
end
