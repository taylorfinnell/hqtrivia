require "../spec_helper"

class MyBot
  include HqTrivia::Bot

  getter words

  @words = {} of String => Int32

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

  @round_starts = 0
  @round_ends = 0
  @reveals = 0
  @num_winners : Int32? = 0

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

class HeartBot
  include HqTrivia::Bot

  getter photo_uploads
  getter photo_votes
  getter photo_results
  getter episode_winners

  @photo_uploads = [] of HqTrivia::Model::HeartPhotoUpload
  @photo_votes = [] of HqTrivia::Model::HeartPhotoVote
  @photo_results = [] of HqTrivia::Model::HeartPhotoResults
  @episode_winners = [] of HqTrivia::Model::HeartEpisodeWinners

  def handle_message(message : HqTrivia::Model::HeartPhotoUpload)
    @photo_uploads << message
  end

  def handle_message(message : HqTrivia::Model::HeartPhotoVote)
    @photo_votes << message
  end

  def handle_message(message : HqTrivia::Model::HeartPhotoResults)
    @photo_results << message
  end

  def handle_message(message : HqTrivia::Model::HeartEpisodeWinners)
    @episode_winners << message
  end
end

module HqTrivia
  describe Bot do
    it "works" do
      messages = File.read("./spec/data/new_messages").each_line.to_a
      show = Model::Show.new(active: true, show_type: "hq-us", prize: 100, show_id: 666, start_time: Time.local)
      coordinator = LocalCoordinator.new("us")
      coordinator.show = show
      connection = Connection::Local.new(messages)

      bot = MyBot.new(coordinator)
      bot.play(connection)

      bot.words.values.max.should eq(70)
      bot.start_time.should eq(show.start_time)
      bot.show_id.should eq(show.show_id)
      bot.prize.should eq(show.prize)
      bot.country.should eq("us")
    end

    it "works with words" do
      messages = File.read("./spec/data/words").each_line.to_a
      show = Model::Show.new(active: true, show_type: "hq-us", game_type: "words", prize: 100, show_id: 666, start_time: Time.local)
      coordinator = LocalCoordinator.new("us")
      coordinator.show = show
      connection = Connection::Local.new(messages)

      bot = WordsBot.new(coordinator)
      bot.play(connection)

      bot.reveals.should eq(20)
      bot.round_starts.should eq(10)
      bot.round_ends.should eq(10)
      bot.num_winners.should eq(5827)
    end

    it "works with heart" do
      messages = File.read("./spec/data/heart").each_line.to_a
      show = Model::Show.new(active: true, show_type: "hq-us", game_type: "heart", prize: 100, show_id: 666, start_time: Time.local)
      coordinator = LocalCoordinator.new("us")
      coordinator.show = show
      connection = Connection::Local.new(messages)

      bot = HeartBot.new(coordinator)
      bot.play(connection)

      # Questions
      bot.photo_uploads.size.should eq(5)
      bot.photo_uploads.map(&.category).sort.should eq([
        "Long Weekend Necessities", "The Only Acceptable Turkey Substitute", "This Should Be a Parade Float", "What You're Buying on Black Friday", "Your Thanksgiving Dinner Contribution",
      ])
      bot.photo_uploads.map(&.scene_id).uniq.should eq([
        "ck3gcpmkh000001zw1knz83cu", "ck3gcpmkk000101zw9koh8lg0", "ck3gcpmkk000201zw9efdh8jo", "ck3gcpmkl000301zweaiqa6ri", "ck3gcpmkl000401zw4o0x5b3a",
      ])
      bot.photo_uploads.map(&.show_id).uniq.should eq([13086])
      bot.photo_uploads.map(&.round).sort.should eq([1, 2, 3, 4, 5])

      # Submitted Pics
      bot.photo_votes.size.should eq(5)
      bot.photo_votes.map(&.category).sort.should eq([
        "Long Weekend Necessities", "The Only Acceptable Turkey Substitute", "This Should Be a Parade Float", "What You're Buying on Black Friday", "Your Thanksgiving Dinner Contribution",
      ])
      bot.photo_votes.map(&.submission_count).sort.should eq([180, 189, 190, 192, 205])
      bot.photo_votes.map(&.round).sort.should eq([1, 2, 3, 4, 5])
      round_votes = bot.photo_votes.sort_by(&.round)

      counts = [9, 10, 8, 5, 10]
      ids = ["ck3gcpmkh000001zw1knz83cu", "ck3gcpmkk000101zw9koh8lg0", "ck3gcpmkk000201zw9efdh8jo", "ck3gcpmkl000301zweaiqa6ri", "ck3gcpmkl000401zw4o0x5b3a"]
      5.times do |idx|
        round = round_votes[idx]
        round.stack.size.should eq(counts[idx])
        round.stack.map(&.scene_id).uniq.sort.should eq([ids[idx]])
      end

      bot.photo_results.size.should eq(20) # (you, first, second, third) * round_count
      bot.photo_results.map(&.category).uniq.sort.should eq([
        "Long Weekend Necessities", "The Only Acceptable Turkey Substitute", "This Should Be a Parade Float", "What You're Buying on Black Friday", "Your Thanksgiving Dinner Contribution",
      ])
      bot.photo_results.map(&.results_type).uniq.sort.should eq(["first", "second", "third", "you"])

      # Winners
      bot.episode_winners.size.should eq(1)
    end
  end
end
