require 'console_creep/stores/logger_store'
require 'console_creep/stores/database_store'
require 'console_creep/authenticators/devise_authenticator'

module ConsoleCreep
  class Config
    attr_accessor :store
    attr_accessor :authenticator
    attr_accessor :log_for_user
    attr_accessor :welcome
    attr_accessor :enabled
    attr_accessor :filters

    def initialize
      @store = Stores::LoggerStore.new
      @authenticator = Authenticators::DeviseAuthenticator.new
      @log_for_user = ->(user) { true }
      @welcome = ->(user) { puts "\n"; puts "Welcome #{user.email}!"; puts "As a reminder, this session is recorded." }
      @enabled = Rails.env.production?
      @filters = []
    end

    def authenticator=(*args)
      auth_class = args.shift
      options = args.extract_options!
      @authenticator = auth_class.new(options)
    end

    def store=(*args)
      store_class = args.shift
      options = args.extract_options!
      klass = if store_class == :database
                Stores::DatabaseStore
              elsif store_class == :logger
                Stores::LoggerStore
              elsif store_class.is_a?(Symbol)
                store_class.to_s.classify.constantize
              elsif store_class.is_a?(String)
                store_class.constantize
              else
                store_class
              end
      @store = klass.new(options)
    end

    def enabled?
      @enabled
    end

    def log_for_user?(user)
      @log_for_user.call(user)
    end

    def filters=(val)
      @filters << Array.wrap(val)
      @filters.flatten!
    end
  end
end
