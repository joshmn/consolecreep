module ConsoleCreep
  module Authenticators
    class Authenticator
      attr_accessor :options

      def initialize(options = {})
        @options = options
      end

      def set_current_user(user)
        IRB.conf[:current_user] = user
      end

      def die
        throw(:halt)
      end
    end
  end
end
