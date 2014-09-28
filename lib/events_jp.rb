require 'events_jp/version'
require 'events_jp/connection'
require 'events_jp/event'
require 'events_jp/event_object/event_object'
require 'events_jp/event_object/atnd'
require 'events_jp/event_object/connpass'
require 'events_jp/event_object/doorkeeper'
require 'events_jp/event_object/zusaar'

module EventsJp
  extend EventsJp::Connection
  extend EventsJp::Event
end
