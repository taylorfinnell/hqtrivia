require "../../spec_helper"

class MyBot
  include HqTrivia::Bot

  getter words

  def initialize(@show : HqTrivia::Model::Show, @coordinator : HqTrivia::Coordinator)
    super
    @words = {} of String => Int32
  end

  def handle_message(message : HqTrivia::Model::Interaction)
    message.metadata.message.split(/\s/).each do |word|
      @words[word.downcase] ||= 0
      @words[word.downcase] += 1
    end
  end
end

module HqTrivia
  describe Bot do
    it "works" do
      messages = File.read("./spec/data/new_messages").each_line.to_a
      show = Model::Show.new(active: true, show_type: "hq-us", prize: 100, show_id: 666, start_time: Time.now)
      connection = Connection::Local.new(messages)

      bot = MyBot.new(show, LocalCoordinator.new("us"))
      bot.play(connection)

      bot.words.values.max.should eq(70)
      bot.start_time.should eq(show.start_time)
      bot.show_id.should eq(show.show_id)
      bot.prize.should eq(show.prize)
      bot.country.should eq("us")
    end
  end
end
