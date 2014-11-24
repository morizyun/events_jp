require 'coveralls'
Coveralls.wear!
require 'codeclimate-test-reporter'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  Coveralls::SimpleCov::Formatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start 'test_frameworks'

require 'events_jp'
require 'rspec'
require 'fakeweb'

def fixture(path)
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

def stub_get(path, fixture_path, options={})
  opts = {
    :body => fixture(fixture_path),
    :content_type => 'application/json; charset=utf-8'
  }.merge(options)
  FakeWeb.register_uri(:get, "#{path}", opts)
end

RSpec.configure do |config|
 config.before(:each) do
   stub_get("#{EventsJp::Atnd::ENDPOINT}?format=json&count=100&start=1", 'event/atnd.json')
   stub_get("#{EventsJp::Atnd::ENDPOINT}?format=json&count=100&start=1&keyword=Ruby", 'event/atnd_ruby.json')
   stub_get("#{EventsJp::Connpass::ENDPOINT}?order=2&count=100&start=1", 'event/connpass.json')
   stub_get("#{EventsJp::Connpass::ENDPOINT}?order=2&count=100&start=1&keyword=Ruby", 'event/connpass_ruby.json')
   stub_get("#{EventsJp::Doorkeeper::ENDPOINT}?locale=ja&sort=starts_at&page=1", 'event/doorkeeper.json')
   stub_get("#{EventsJp::Zusaar::ENDPOINT}?count=100&start=1", 'event/zusaar.json')
   stub_get("#{EventsJp::Zusaar::ENDPOINT}?count=100&start=1&keyword=Ruby", 'event/zusaar_ruby.json')
   stub_get("#{EventsJp::Zusaar::ENDPOINT}?count=100&start=1&keyword=Ruby", 'event/zusaar_ruby.json')
  end
end