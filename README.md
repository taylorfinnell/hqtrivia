# hqtrivia

A small framework for building HQ Trivia bots.

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

  def initialize(@show : HqTrivia::Model::Show, @coordinator : HqTrivia::Coordinator)
    super
    @words = {} of String => Int32
  end

  def handle_message(message : HqTrivia::Model::Interaction)
    message.metadata.message.split(/\s/).each do |word|
      @words[word.downcase] ||= 0
      @words[word.downcase] +=  1
    end
  end
end

coordinator = HqTrivia::HqCoordinator.new("us")
HqTrivia.on_show(coordinator) do |show|
  bot = WordFrequencyBot.new(show, coordinator)

  bot.play
end
```

Other messages that can be handled include

- `HqTriva::Model::Question`
- `HqTriva::Model::QuestionSummary`
- `HqTriva::Model::QuestionClosed`
- `HqTriva::Model::QuestionFinished`
- `HqTriva::Model::PostGame`
- `HqTriva::Model::Interaction`
- `HqTriva::Model::GameSummary`
- `HqTriva::Model::BroadcastStats`
- `HqTriva::Model::BroadcastEnded`
- `HqTriva::Model::UnknownMessage`


## Contributors

- [taylorfinnell](https://github.com/taylorfinnell) Taylor Finnell - creator, maintainer
