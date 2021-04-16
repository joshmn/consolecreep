require 'console_creep/stores/logger_store'
require 'console_creep/stores/database_store'
require 'console_creep/authorizations/devise'

module ConsoleCreep
  class Config
    attr_reader :store
    attr_reader :authorization

    attr_accessor :log_for_user
    attr_accessor :welcome
    attr_accessor :enabled
    attr_accessor :filters

    def initialize
      @store = Stores::LoggerStore.new
      @authorization = Authorizations::Devise.new
      @log_for_user = ->(user) { true }
      @welcome = ->(user) { puts "\n"; puts "Welcome #{user.email}!"; puts "As a reminder, this session is recorded." }
      @enabled = Rails.env.production?
      @filters = []
    end

    def authorization=(*args)
      auth_class = args.shift
      options = args.extract_options!
      klass = case auth_class
              when :devise
                Authorization::Devise
              when Symbol
                raise ArgumentError, "Unknown authorization class for #{auth_class.inspect}"
              when String
                auth_class.constantize
              end

      @authorization = klass.new(options)
    end

    def store=(*args)
      store_class = args.shift
      options = args.extract_options!
      klass = case store_class
              when :database
                Stores::DatabaseStore
              when :logger
                Stores::LoggerStore
              when Symbol
                store_class.to_s.classify.constantize
              when String
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
