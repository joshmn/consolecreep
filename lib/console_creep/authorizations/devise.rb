require 'console_creep/authorization'

module ConsoleCreep
  module Authorizations
    class Devise < Authorization
      def initialize(options = {class: 'User'})
        super
        @options = options
      end

      def resource_class
        @options[:class].to_s.constantize
      end

      def call
        ActiveRecord::Base.logger.silence do
          print 'Email address: '
          email = gets
          user = resource_class.find_by(email: email.strip.downcase)
          unless user
            die 'Email not found in database! Exiting...'
          end

          print 'Password: '
          pass = $stdin.noecho(&:gets)
          if user.valid_password?(pass.strip)
            success(user)
          else
            die 'Provided password is not correct! Exiting...'
          end
        end
      end
    end
  end
end
