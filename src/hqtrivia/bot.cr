module HqTrivia
  # The HqTrivia bot, given a connection it has call backs for messages received
  module Bot
    @show : HqTrivia::Model::Show?

    def play(connection = Connection::Hq.new, blocking = true)
      connection.on_show do |show|
        @show = show
      end

      connection.on_message do |message|
        handle_message(message)
      end

      connection.connect(blocking)
    end

    # Called when the connection receives a `Model::Question`
    protected def handle_message(message : Model::Question)
    end

    # Called when the connection receives a `Model::BroadcastEnded`
    protected def handle_message(message : Model::BroadcastEnded)
    end

    # Called when the connection receives a `Model::BroadcastStats`
    protected def handle_message(message : Model::BroadcastStats)
    end

    # Called when the connection receives a `Model::GameSummary`
    protected def handle_message(message : Model::GameSummary)
    end

    # Called when the connection receives a `Model::Interaction`
    protected def handle_message(message : Model::Interaction)
    end

    # Called when the connection receives a `Model::PostGame`
    protected def handle_message(message : Model::PostGame)
    end

    # Called when the connection receives a `Model::QuestionClosed`
    protected def handle_message(message : Model::QuestionClosed)
    end

    # Called when the connection receives a `Model::QuestionFinished`
    protected def handle_message(message : Model::QuestionFinished)
    end

    # Called when the connection receives a `Model::QuestionSummary`
    protected def handle_message(message : Model::QuestionSummary)
    end

    # Called when the connection receives a `Model::UnknownQuestion`
    protected def handle_message(message : Model::UnknownMessage)
    end

    # The start time of the current show, nil if no show is going
    private def start_time
      @show.try &.start_time
    end

    # The id of the current show, nil if no show is going
    private def show_id
      @show.try &.show_id
    end

    # The prize of the current show, nil if no show is going
    private def prize
      @show.try &.prize
    end
  end
end
