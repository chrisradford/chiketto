[![Build Status](https://travis-ci.org/chrisradford/chiketto.svg?branch=master)](https://travis-ci.org/chrisradford/chiketto)
[![Code Climate](https://codeclimate.com/github/chrisradford/chiketto.png)](https://codeclimate.com/github/chrisradford/chiketto)
[![Coverage Status](https://coveralls.io/repos/chrisradford/chiketto/badge.png?branch=master)](https://coveralls.io/r/chrisradford/chiketto?branch=master)

# チケット - Chiketto

Chiketto is a ruby gem for interacting with the Eventbrite V3 API, chiketto in Japanese literally means 'Ticket' and seems like a reasonable name given most of the obvious options are already taken. Chiketto works with Ruby 2.0 and above, since this is a new gem it makes little sense to support older, unsupported version of Ruby.

**This Gem is still very much a work in progress and is not recommended for production use**

## Installation

Add this line to your application's Gemfile:

    gem 'chiketto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chiketto

## Usage

Chiketto will read your API access token from the `EVENTBRITE_API_TOKEN` enviroment variable, at some point it will allow this to be set explicitly.

Chiketto allows you to acces data from the Eventbrite API and formats it as Ruby objects for use within your application.

For example, once you've found an event on the API, Chiketto provides a simple interface for the various pieces of data to make working with it easier.

```
event = Chiketto::Event.find 123456
event.name            # => 'Event Name'
event.name.html       # => '<p>Event Name</p>'
event.organizer       # => Chicketto::Organizer
event.organizer.name  # => 'Organizer Name'
```

You can also use the search endpoint on the API to look up events and have an Array of events returned:

```
Chiketto::Event.search 'name'
```

Finally, for now, Chiketto allows you to list out all the possible Categories on the Eventbrite API, returning an Array of Category objects.

```
Chiketto::Category.list
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chiketto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
