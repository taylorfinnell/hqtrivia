require "./hqtrivia/*"

module HqTrivia
  # :nodoc:
  @@LOGGER = Logger.new

  # HqTrivia logging instance
  def self.logger
    @@LOGGER
  end
end
