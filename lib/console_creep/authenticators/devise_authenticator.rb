require 'console_creep/authenticators/authenticator'

module ConsoleCreep
  module Authenticators
    class DeviseAuthenticator < Authenticator
      def initialize(options = {class: 'User'})
        @options = options
      end

      def collection
        @options[:class].to_s.constantize
      end

      def call
        ActiveRecord::Base.logger.silence do
          print 'Email address: '
          email = gets
          user = collection.find_by(email: email.strip.downcase)
          unless user
            puts 'Email not found in database! Exiting...'
            die
          end

          print 'Password: '
          pass = $stdin.noecho(&:gets)
          if user.valid_password?(pass.strip)
            if @options[:if]
              if @options[:if].call(user)
                set_current_user(user)
                ConsoleCreep.config.welcome.call(user)
              else
                puts "User not admin."
                die
              end
            else
              set_current_user(user)
              ConsoleCreep.config.welcome.call(user)
            end
          else
            puts 'Provided password is not correct! Exiting...'
            die
          end
        end
      end
    end
  end
end
