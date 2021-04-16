module ConsoleCreep
  class Authorization
    attr_accessor :options

    def initialize(options = {})
      @options = options
    end

    private

    def success(user)
      set_current_user(user)
      ConsoleCreep.config.welcome.call(user)
    end

    def set_current_user(user)
      IRB.conf[:current_user] = user
    end

    def die(msg)
      puts msg
      throw(:halt)
    end
  end
end
