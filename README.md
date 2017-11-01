# SwitchDb

A command-line interface for a database dumpfile

## Installation

```sh
git clone https://github.com/alpaca-tc/switch_db
cd switch_db

bundle install
bundle exec rake install
```

## Usage

```
# Show dumpfile list
switch_db list

# Change user_name and as so on
switch_db config [key:value...]

# Remove dumpfile
switch_db rm <name>

# Store database
switch_db store <name> --database_names [database_names...]

# Restore database
switch_db restore <name>
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.
To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alpaca-tc/switch_db.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
