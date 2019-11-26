require "json"

module HqTrivia
  module Model
    # :nodoc:
    class MessageTypes
      # :nodoc:
      MESSAGE_LIST = %w(broadcastEnded broadcastStats gameSummary interaction postGame question
        questionClosed questionFinished questionSummary kicked endRound hideWheel letterReveal showWheel startRound wordsGameResult
        surveyQuestion surveyResults checkpoint checkpointSummary heart-episode-winners heart-finalist-intro heart-finalist-upload-status
        heart-finalist-upload-update heart-finalist-vote heart-finalist-walkthrough heart-photo-results heart-photo-upload heart-photo-vote)
    end
  end
end
