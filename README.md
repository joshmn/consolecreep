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
  ## Data Store
  # 
  # Defaults to `Logger.new("log/console.log")`
  #   config.store = :logger  
  # Change the filepath:
  #   config.store = :logger, { file: Rails.root.join("log/poodle.log") }
  #    
  # Use the database store (see Database Logging in the README.md)
  #   config.store = :database
  #
  # Use the database store and don't store the evaluation result
  # options are `:error`, `:result`, `:command`
  #   config.store = :database, { model: 'ConsoleCreepLog', except: [:result] }
  
  ## Enabled for this Rails.env (default is `Rails.env.production?`)
  #   config.enabled = true
  
  ## Enabled for the logged-in user (default is true)
  #  config.log_for_user = ->(user) { !user.doctor? }

  ## Change the authentication scheme
  #   config.authenticator = :devise
  # if your class name is Admin:
  #   config.authenticator = :devise, { class: 'Admin' }
end
```

### Database logging

Generate this model:

```bash 
rails g model ConsoleCreepLog user:references{polymorphic} command:text result:text error:text time:time --no-timestamps
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshmn/consolecreep. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joshmn/consolecreep/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ConsoleCreep project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/joshmn/consolecreep/blob/master/CODE_OF_CONDUCT.md).
