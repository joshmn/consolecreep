module Rails
  module ConsoleMethods
    def self.included(_base)
      catch(:halt) do
        ConsoleCreep.config.authenticator.call
        return true
      end
      exit("Exiting console.")
    end
  end
end
