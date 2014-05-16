[![Build Status](https://travis-ci.org/chrisradford/chiketto.svg?branch=master)](https://travis-ci.org/chrisradford/chiketto)
[![Code Climate](https://codeclimate.com/github/chrisradford/chiketto.png)](https://codeclimate.com/github/chrisradford/chiketto)
[![Coverage Status](https://coveralls.io/repos/chrisradford/chiketto/badge.png)](https://coveralls.io/r/chrisradford/chiketto)

# チケット - Chiketto

Chiketto is a ruby gem for interacting with the Eventbrite V3 API, chiketto in Japanese literally means 'Ticket' and seems like a reasonable name given most of the obvious options are already taken.

## Installation

Add this line to your application's Gemfile:

    gem 'chiketto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chiketto

## Usage

```
Chiketto.token = YOUR_API_TOKEN

event = Chiketto::Event.find 12
Chiketto::Event::Attendees event or Chiketto::Event::Attendees 12

Chiketto::Event.search 'name'
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/chiketto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
