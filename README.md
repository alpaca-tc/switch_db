# SwitchDb

A command-line interface for a database dumpfile

## Installation

### from rubygems

```
gem install switch_db
```

### from github

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
switch_db store <name> --database_names [database_name,database_name...]

# Restore database
switch_db restore <name>
```

Example

```
# Show list
$ switch_db list
0: initial_database
1: new_feature
2: latest_database

$ echo $(git rev-parse --abbrev-ref HEAD)
master

# Store databases
$ switch_db store $(git rev-parse --abbrev-ref HEAD) --database_names application_development,application_test
Stored database a 'application_development'
Stored database a 'application_test'

$ switch_db list
0: initial_database
1: new_feature
2: latest_database
3: master

# Restore databases
$ switch_db restore master
Restored database a 'application_development'
Restored database a 'application_test'

# Set default username and password
switch_db config user_name:root password:password
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake spec` to run the tests.
To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alpaca-tc/switch_db.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
