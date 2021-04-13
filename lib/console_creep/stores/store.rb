module ConsoleCreep
  module Stores
    class Store
      attr_reader :options
      def initialize(options = {})
        @options = options
      end

      def call(user, command, result, error)
        if ConsoleCreep.config.log_for_user?(user)
          store(user, command, result, error)
        end
      end
    end
  end
end
