$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Event' do
  describe '.get_all' do
    context 'with keyword' do
      before(:each) do
        @result = EventsJp.get_events(keyword: 'Ruby',  service_limit: 10)
      end

      it 'return each more than 10 events' do
        expect(@result.count).to be > 40
      end
    end

    context 'no keyword' do
      before(:each) do
        @result = EventsJp.get_events(service_limit: 10)
      end

      it 'return each 100 events' do
        expect(@result.count).to be > 40
      end
    end
  end
end
