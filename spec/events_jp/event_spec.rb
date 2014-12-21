$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Event' do
  describe '.get_all' do
    context 'with keyword' do
      it 'return each more than 10 events' do
        results, errors = EventsJp.get_events(keyword: 'Ruby',  service_limit: 10)
        expect(errors).to be == []
        expect(results.count).to be > 40
        expect(results.any?{|e| e.nil? }).to be_falsy
      end
    end

    context 'no keyword' do
      it 'return each 100 events' do
        results, errors = EventsJp.get_events(service_limit: 10)
        expect(errors).to be == []
        expect(results.count).to be > 40
      end
    end

    context 'when raise errors in convert_response method' do
      it 'returns error' do
        allow(EventsJp::Atnd).to receive(:convert_response).and_raise(StandardError)
        results, errors = EventsJp.get_events(service_limit: 10)
        expect(errors).not_to be_empty
        expect(results.count).to be > 40
      end
    end
  end
end
