# frozen_string_literal: true

module ConsoleCreep
  module Generators
    class ModelGenerator < Rails::Generators::Base
      desc 'Creates a ConsoleCreep model for storing the data.'

      # :nodoc:
      def copy_initializer
        name = ARGV[0].presence || "ConsoleCreepLog"
        generate 'model', "#{name}", "user:references{polymorphic} command:text result:text error:text time:time --no-timestamps --no-test-framework --no-fixture"
      end
    end
  end
end