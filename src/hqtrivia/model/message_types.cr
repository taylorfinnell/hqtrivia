require "json"

module HqTrivia
  module Model
    # :nodoc:
    class MessageTypes
      # :nodoc:
      MESSAGE_LIST = %w(broadcastEnded broadcastStats gameSummary interaction postGame question
        questionClosed questionFinished questionSummary kicked endRound hideWheel letterReveal showWheel startRound wordsGameResult
        surveyQuestion surveyResults)
    end
  end
end
