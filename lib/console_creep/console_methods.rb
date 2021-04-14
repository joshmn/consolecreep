module Rails
  module ConsoleMethods
    def self.included(_base)
      catch(:halt) do
        ConsoleCreep.config.authenticator.call
        return true
      end
      exit(0)
    end
  end
end
