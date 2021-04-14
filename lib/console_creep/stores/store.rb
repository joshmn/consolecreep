module ConsoleCreep
  module Stores
    class Store
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def call(user, command, result, error)
        if store?(user, command, result, error)
          store(user, command, result, error)
        end
      end

      private

      def store?(user, command, result, error)
        return false unless ConsoleCreep.config.log_for_user?(user)

        ConsoleCreep.config.filters.each do |filter|
          filter_result = filter.call(user, command, result, error)
          return false if filter_result
        end

        true
      end
    end
  end
end
