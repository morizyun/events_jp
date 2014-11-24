# events_jp [![Gem Version](https://badge.fury.io/rb/events_jp.svg)](http://badge.fury.io/rb/events_jp) [![Build Status](https://travis-ci.org/morizyun/events_jp.svg)](https://travis-ci.org/morizyun/events_jp) [![Code Climate](https://codeclimate.com/github/morizyun/events_jp/badges/gpa.svg)](https://codeclimate.com/github/morizyun/events_jp) [![Test Coverage](https://codeclimate.com/github/morizyun/events_jp/badges/coverage.svg)](https://codeclimate.com/github/morizyun/events_jp) [![Dependency Status](https://gemnasium.com/morizyun/events_jp.svg)](https://gemnasium.com/morizyun/events_jp)

A Ruby wrapper for atnd/connpass/doorkeeper/zusaar API

## Installation

Add this line to your application's Gemfile:

    gem 'events_jp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install events_jp

## Usage

### Search events

```ruby
events = EventsJp.get_events(keyword: 'Ruby')
events.each do |e|
  puts "#{e.service} - #{e.title}"
end
```

* Unfortunately, Doorkeeper don't support keyword search....

### Get all events

```ruby
events = EventsJp.get_events(service_limit: 100)
events.each do |e|
  puts "#{e.service} - #{e.title}"
end
```

### Complement

* The response is a [Hashie::Mash](https://github.com/intridea/hashie#mash) object (dot-accessible Hash).
    
## Response Attributes
    
The response is as follows(similar atnd response);
    
- service: String(atnd/connpass/doorkeeper/zusaar)
- address: String
- catch: String(nothing in doorkeeper)
- title: String
- event_url: String
- started_at: DateTime
- ended_at: DateTime
- place: String
- lon: Float(longitude)
- lat: Float(latitude)
- limit: Integer
- accepted: Integer
- waiting: Integer

## API reference

- [ATND API リファレンス](http://api.atnd.org/)
- [APIリファレンス - connpass](http://connpass.com/about/api/)
- [Doorkeeper API | Doorkeeper](http://www.doorkeeperhq.com/developer/api)
- [APIリファレンス｜Zusaar](http://www.zusaar.com/doc/api.html)

## Supported versions

- Ruby 2.0.0 or higher

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/morizyun/events_jp/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

