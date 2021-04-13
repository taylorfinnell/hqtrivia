require "json_mapping"
require "./hqtrivia/*"

# Framework for creating HQ Trivia and HQ Words bots
module HqTrivia
  # :nodoc:
  @@LOGGER = Logger.new

  # :nodoc:
  @@AUTH = Auth.new

  @@CONFIG = Config.new

  # HqTrivia logging instance
  def self.logger
    @@LOGGER
  end

  # Set the logger to an IO
  def self.logger=(logger)
    @@LOGGER = logger
  end

  # Auth singleton
  def self.auth
    @@AUTH
  end

  def self.config
    @@CONFIG
  end

  def self.configure
    yield config
  end

  # When an active `Show` is seen, it's yielded to the block
  def self.on_show(coordinator : Coordinator, blocking = true, &block : Model::Show ->)
    show_coordinator = ShowCoordinator.new(coordinator)
    show_coordinator.on_show(blocking, &block)
  end
end
