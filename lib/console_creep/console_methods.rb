module Rails
  module ConsoleMethods
    def self.included(_base)
      catch(:halt) do
        ConsoleCreep.config.authorization.call
        return true
      end
      exit("Exiting console.")
    end
  end
end
