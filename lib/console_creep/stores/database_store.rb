require 'console_creep/stores/store'

module ConsoleCreep
  module Stores
    class DatabaseStore < Store
      def store(user, command, result, error)
        ActiveRecord::Base.logger.silence do
          record = { user: user, command: command, result: result, error: error }
          record.delete_if { |k, _v| except_columns.include?(k) }
          model_name.create(record)
        end
      end

      private

      def except_columns
        Array.wrap(options[:except])
      end

      def model_name
        options[:model].to_s.constantize
      end
    end
  end
end
