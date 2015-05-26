[![Build Status](https://travis-ci.org/chrisradfordltd/chiketto.svg?branch=master)](https://travis-ci.org/chrisradfordltd/chiketto)
[![Code Climate](https://codeclimate.com/github/chrisradfordltd/chiketto.png)](https://codeclimate.com/github/chrisradfordltd/chiketto)

# チケット - Chiketto

Chiketto is a ruby gem for interacting with the Eventbrite V3 API, in Japanese chiketto means 'Ticket'. This library is tested on Ruby 2.0 and above, though may work on 1.9.3.

## V1 to V3 Update

In version 1.0 Chiketto removed the last remaining uses of the V1 API (creating events and organizers), and moved to exclusively using the V3 API.

Part of the V1 to V3 API change includes a new naming convention for parameters passed to POST requests, the full docs can be found at: http://www.eventbrite.com/developer/v3/

For example pre-V1.0 Chiketto:

```
Chiketto::Organizer.create name: 'Test Organizer'
```

Would, in V1.0 become:

```
Chiketto::Organizer.create 'organizer.name': 'Test Organizer'
```

In the V3 API version the required fields for each endpoint have also changed, for example, `currency` is now a required field for new events. For full details please refer to the API documentation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'chiketto'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install chiketto
```

## Usage

Chiketto will read your API access token from the `EVENTBRITE_API_TOKEN` environment variable, you can also set it explicitly:

```ruby
Chiketto.api_key = 'YOUR_API_KEY'
```

Chiketto allows you to access data from the Eventbrite API and formats it as Ruby objects for use within your application.

For example, once you've found an event on the API, Chiketto provides a simple interface for the various pieces of data to make working with it easier.

```ruby
event = Chiketto::Event.find 123456
event.name                              # => 'Event Name'
event.name.html                         # => '<p>Event Name</p>'
event.organizer                         # => Chicketto::Organizer
event.organizer.name                    # => 'Organizer Name'
```

You can also create new events, or update existing events (using the V1 API) and Chiketto will then return the updated / new event pulled from the V3 API.

```ruby
event.update name: 'Name'
Chiketto::Event.create name: 'Name', start_date: …, end_date: …
```

You can also use the search endpoint on the API to look up events and have an Array of events returned:

```ruby
Chiketto::Event.search 'name'
```

Chiketto also allows you to list out all the possible Categories on the Eventbrite API, returning an Array of Category objects.

```ruby
Chiketto::Category.list
```

For more supported objects, API calls, and methods, I suggest looking at the source code.

## Contributing

1. Fork it ( https://github.com/chrisradfordltd/chiketto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
