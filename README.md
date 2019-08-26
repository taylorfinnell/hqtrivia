# hqtrivia

A small framework for building HQ Trivia and HQ Words bots.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  hqtrivia:
    github: taylorfinnell/hqtrivia
```

## Usage

```crystal
require "hqtrivia"
```

```crystal
class WordFrequencyBot
  include HqTrivia::Bot

  getter words
  @words = {} of String => Int32

  def handle_message(message : HqTrivia::Model::Interaction)
    message.metadata.message.split(/\s/).each do |word|
      @words[word.downcase] ||= 0
      @words[word.downcase] +=  1
    end
  end
end

coordinator = HqTrivia::HqCoordinator.new("us")
HqTrivia.on_show(coordinator) do |show|
  bot = WordFrequencyBot.new(coordinator)

  bot.play
end
```

**HQ Trivia Messagges**

- `HqTriva::Model::Question`
- `HqTriva::Model::QuestionSummary`
- `HqTriva::Model::QuestionFinished`
- `HqTriva::Model::GameSummary`
- `HqTriva::Model::SurveyQuestion`
- `HqTriva::Model::SurveyResults`
- `HqTriva::Model::Checkpoint`
- `HqTriva::Model::CheckpointSummary`

**HQ Words Messaegs**

- `HqTriva::Model::ShowWheel`
- `HqTriva::Model::HideWheel`
- `HqTriva::Model::StartRound`
- `HqTriva::Model::EndRound`
- `HqTriva::Model::WordsGameResult`

**Shared Messages**

- `HqTriva::Model::QuestionClosed`
- `HqTriva::Model::PostGame`
- `HqTriva::Model::Interaction`
- `HqTriva::Model::UnknownMessage`
- `HqTriva::Model::BroadcastStats`
- `HqTriva::Model::BroadcastEnded`
- `HqTriva::Model::Kicked`

## Contributors

- [taylorfinnell](https://github.com/taylorfinnell) Taylor Finnell - creator, maintainer
