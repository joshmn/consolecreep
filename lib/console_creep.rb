# frozen_string_literal: true

require_relative "console_creep/version"
require_relative "console_creep/config"

module ConsoleCreep
  def self.config
    @config ||= Config.new
  end

  def self.setup
    yield config
    if config.enabled?
      require_relative "console_creep/console_methods"
      require_relative "console_creep/irb_hooks"
    end
  end
end
