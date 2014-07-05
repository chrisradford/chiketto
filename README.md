[![Build Status](https://travis-ci.org/chrisradfordltd/chiketto.svg?branch=master)](https://travis-ci.org/chrisradfordltd/chiketto)
[![Code Climate](https://codeclimate.com/github/chrisradfordltd/chiketto.png)](https://codeclimate.com/github/chrisradfordltd/chiketto)

# チケット - Chiketto

Chiketto is a ruby gem for interacting with the Eventbrite V3 API, chiketto in Japanese literally means 'Ticket' and seems like a reasonable name given most of the obvious options are already taken. Chiketto works with Ruby 2.0 and above, since this is a new gem it makes little sense to support older, unsupported version of Ruby.

Chiketto falls back to the V1 API when dealing with updating and creating events, those these are the only instances. It's also worth noting that when using the V1 API Chiketto will make a second call to the V3 API in order to fetch the data. This is due to changes in the way data is formatted and what data is returned between the two API versions.

**This Gem is still very much a work in progress though may now be suitable for production use - version 1.0 should be ready late summer 2014**

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

Finally, for now, Chiketto allows you to list out all the possible Categories on the Eventbrite API, returning an Array of Category objects.

```ruby
Chiketto::Category.list
```

## Contributing

1. Fork it ( https://github.com/chrisradfordltd/chiketto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
