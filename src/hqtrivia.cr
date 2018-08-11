require "./hqtrivia/*"

module HqTrivia
  # :nodoc:
  @@LOGGER = Logger.new
  @@AUTH = Auth.new

  # HqTrivia logging instance
  def self.logger
    @@LOGGER
  end

  def self.logger=(logger)
    @@LOGGER = logger
  end

  def self.auth
    @@AUTH
  end

  def self.on_show(coordinator : Coordinator, blocking = true, &block : Model::Show ->)
    show_coordinator = ShowCoordinator.new(coordinator)
    show_coordinator.on_show(blocking, &block)
  end
end
