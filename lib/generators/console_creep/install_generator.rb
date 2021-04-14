# frozen_string_literal: true

module ConsoleCreep
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      desc 'Creates a ConsoleCreep initializer.'

      # :nodoc:
      def copy_initializer
        template 'console_creep.rb', 'config/initializers/console_creep.rb'
      end
    end
  end
end