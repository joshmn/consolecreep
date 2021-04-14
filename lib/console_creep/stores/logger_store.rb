require 'console_creep/stores/store'

module ConsoleCreep
  module Stores
    class LoggerStore < Store

      def initialize(options = {})
        super
        @options[:file] ||= Rails.root.join("log/console.log")
        @logger = Logger.new(@options[:file])
      end

      def store(user, command, result, error)
        if error
          @logger.error(user: user, command: command, error: error)
        else
          @logger.info(user: user, command: command, result: result)
        end
      end
    end
  end
end
