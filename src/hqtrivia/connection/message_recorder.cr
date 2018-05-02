require "file_utils"

module HqTrivia
  module Connection
    class MessageRecorder
      BASE_PATH = "/tmp"

      def initialize(show_id : Int32)
        @replay_dir = "#{BASE_PATH}/#{show_id}"
        FileUtils.mkdir(@replay_dir)
      end

      def record(msg)
        File.open("#{@replay_dir}/replay", "a") do |file|
          file.puts(msg)
        end
      end
    end
  end
end
