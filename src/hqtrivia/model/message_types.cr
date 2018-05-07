require "json"

module HqTrivia
  module Model
    class MessageTypes
      MESSAGE_LIST = %w(broadcastEnded broadcastStats gameSummary interaction postGame question
        questionClosed questionFinished questionSummary kicked)
    end
  end
end
