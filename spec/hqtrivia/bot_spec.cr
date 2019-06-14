require "../spec_helper"

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

class WordsBot
  include HqTrivia::Bot

  getter round_starts
  getter round_ends
  getter reveals
  getter num_winners

  @num_winners : Int32?

  def initialize(@show : HqTrivia::Model::Show, @coordinator : HqTrivia::Coordinator)
    super
    @round_starts = 0
    @round_ends = 0
    @reveals = 0
    @num_winners = 0
  end

  def handle_message(message : HqTrivia::Model::StartRound)
    @round_starts += 1
  end

  def handle_message(message : HqTrivia::Model::EndRound)
    @round_ends += 1
  end

  def handle_message(message : HqTrivia::Model::LetterReveal)
    @reveals += 1
  end

  def handle_message(message : HqTrivia::Model::WordsGameResult)
    @num_winners = message.num_winners
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

    it "works with words" do
      messages = File.read("./spec/data/words").each_line.to_a
      show = Model::Show.new(active: true, show_type: "hq-us", game_type: "words", prize: 100, show_id: 666, start_time: Time.now)
      connection = Connection::Local.new(messages)

      bot = WordsBot.new(show, LocalCoordinator.new("us"))
      bot.play(connection)

      bot.reveals.should eq(20)
      bot.round_starts.should eq(10)
      bot.round_ends.should eq(10)
      bot.num_winners.should eq(5827)
    end
  end
end
