# ConsoleCreep

Supervise your Rails console.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'console_creep'
```

And then execute:

    $ bundle install

Install the initializer:

    $ rails g console_creep:install
    
## Usage

```bash 
$ rails c 

Loading development environment (Rails 6.1.3.1)
Email address: admin@example.com
Password: *******
Welcome admin@example.com!
As a reminder, this session is recorded.
irb(main):001:0> 
```

## Configuration

```ruby 
ConsoleCreep.setup do |config|
  # == Enabled
  #
  # If ConsoleCreep should be enabled for the current environment.
  #
  # Default:
  #   config.enabled = Rails.env.production?
  #
  # config.enabled = Rails.env.staging? || Rails.env.production?
  #
  # == Authorization
  #
  # How you want to handle a user logging into Rails Console. Defaults
  # to a `:devise` strategy, which allows you to login with an email/password combo.
  #
  # Default:
  #   config.authorization = :devise
  #
  # You can optionally set the class of the Devise user that is presumed to be an admin, or
  # have an admin flag.
  #
  # config.authorization = :devise, { class: "AdminUser" }
  #
  # Or use a proc to check if the record is an admin record:
  #
  # config.authorization = :devise, { class: "User", if: ->(user) { user.admin? } }
  #
  # == Store
  #
  # Where the logs of commands, results, and errors are stored. Options are `:logger` and `:database`.
  # Defaults to `:logger` and writing to `log/console.log`.
  #
  # Default:
  #   config.store = :logger
  #
  # Change the file:
  #   config.store = :logger, { file: Rails.root.join("log/creep.log") }
  #
  # Or log everything to the database. This assumes you have a model called `ConsoleCreepLog`. See README.md for a migration.
  #   config.store = :database
  #
  # Change the model:
  #   config.store = :database, { model: "ConsoleLog" }
  #
  # Skip storing certain parts of the console process (options are `:command`, `:result`, and `:error`)
  #   config.store = :database, { model: "ConsoleLog", except: [:result] }
  #
  # == Welcome Message
  #
  # Set the welcome message. Use a proc or something that responds to `#call`.
  #
  # Default:
  #   config.welcome = ->(user) { puts "\n Welcome #{user.email}!\n\nReminder: These sessions are recorded." }
  #
  # == Skip logging for a specific user
  #
  # Optionally skip logging for a specific authenticated user. Send it anything that responds to `#call`.
  #
  # Default:
  #   config.log_for_user = ->(user) { true }
  # == Filtering out specific results
  #
  # Pass an array of filter objects — an object that responds to `.call` and accepts arguments of `user`, `command`, `result`, `error`,
  # and return false if you want to exclude it from being stored by your `store`.
  #
  # Default:
  #   config.filters << ->(user, command, result, error) { true }
  #
  # Ignore everything that's an error:
  #   config.filters << ->(user, command, result, error) { error.present? }
  #
  # log_for_user takes precedence.
end
```

### Database logging

Generate the model and migration:

```bash
rails g console_creep:model 
```

will generate a model named `ConsoleCreepLog` along with a migration.

```bash
rails g console_creep:model ConsoleLog
```

will generate a model named `ConsoleLog` along with a migration.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmn/consolecreep. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joshmn/consolecreep/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ConsoleCreep project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joshmn/consolecreep/blob/master/CODE_OF_CONDUCT.md).
