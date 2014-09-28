# events_jp

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
res = EventsJp.get_event(keyword: 'Python')
res.each do |key, events|
  events.each do |e|
    puts "#{key} - #{e.title}"
  end
end
```

* Unfortunately, Doorkeeper don't support keyword search....

### Get all events

```ruby
res = EventsJp.get_event(curator_limit: 100)
res.each do |key, events|
  events.each do |e|
    puts "#{key} - #{e.title}"
  end
end
```

### Complement

* The response is a [Hashie::Mash](https://github.com/intridea/hashie#mash) object (dot-accessible Hash).
* You can use the same query parameters on the official API reference.

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
