require "log"

module HqTrivia
  # A Logger class that supports setting log level from the environment.
  class Logger
    def initialize(@logger : ::Log = ::Log.for("hqtrivia"))
      @logger.level = log_level
    end

    # Returns the `Logger` log level.
    def level
      @logger.level
    end

    # :nodoc:
    private def log_level
      case ENV["LOG_LEVEL"]?.to_s.upcase
      when "DEBUG"
        ::Log::Severity::Debug
      when "INFO"
        ::Log::Severity::Info
      when "WARN"
        ::Log::Severity::Warn
      when "ERROR"
        ::Log::Severity::Error
      when "FATAL"
        ::Log::Severity::Fatal
      else
        ::Log::Severity::Info
      end
    end

    def debug(msg)
      @logger.debug { msg }
    end

    def info(msg)
      @logger.info { msg }
    end

    def warn(msg)
      @logger.warn { msg }
    end

    def error(msg)
      @logger.error { msg }
    end

    def fatal(msg)
      @logger.fatal { msg }
    end
  end
end
