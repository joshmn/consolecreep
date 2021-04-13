module ConsoleCreep
  module IRBHooks
    attr_accessor :current_user

    def initialize(irb, workspace = nil, input_method = nil)
      @current_user = IRB.conf[:current_user]
      super
    end

    def evaluate(*args, &block)
      begin
        result = super(*args, &block)
        ConsoleCreep.config.store.call(@current_user, args.first.chomp, inspect_last_value.chomp, nil)
        result
      rescue StandardError => e
        ConsoleCreep.config.store.call(@current_user, args.first.chomp, nil, e.message)
        raise e
      end
    end
  end
end

if defined?(IRB)
  IRB::Context.attr_accessor :current_user
  IRB::Context.prepend(ConsoleCreep::IRBHooks)
end
