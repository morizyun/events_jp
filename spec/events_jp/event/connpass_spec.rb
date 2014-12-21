$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Conpass' do
  describe '.convert_response' do
    let!(:response) { %[{"events": [{"address": "sample"}]}] }
    it 'converts to Array' do
      result = EventsJp::Connpass.convert_response(response)
      expect(result.class).to eq(Array)
      expect(result.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      it 'returns conpass API results' do
        results, errors = EventsJp::Connpass.get_events(keyword: 'Ruby', limit: 100)
        expect(errors).to be == []
        expect(results.count).to eq(100)
        expect(results.first.title).to eq('NDS#39 Niigata.pm tech talk')
      end
    end

    context 'no keyword' do
      it 'returns conpass API results' do
        results, errors = EventsJp::Connpass.get_events(limit: 100)
        expect(errors).to be == []
        expect(results.count).to eq(100)
        expect(results.first.service).to eq('connpass')
        expect(results.first.title).to eq('キイロイトリ勉強会')
        expect(results.first.catch).to eq('キイロイトリの魅力を勉強してください')
        expect(results.first.event_url).to eq('http://connpass.com/event/14/')
        expect(results.first.started_at).to eq(DateTime.parse('2038-01-18T03:13:10+09:00'))
        expect(results.first.ended_at).to eq(DateTime.parse('2038-01-18T03:14:10+09:00'))
        expect(results.first.address).to eq('東京')
        expect(results.first.place).to eq('どこか')
        expect(results.first.lat).to eq(35.6894875)
        expect(results.first.lon).to eq(139.6917064)
        expect(results.first.limit).to eq(10)
        expect(results.first.accepted).to eq(2)
        expect(results.first.waiting).to eq(0)
      end
    end

    context 'when raise errors in convert_response method' do
      it 'returns error' do
        allow(EventsJp::Connpass).to receive(:convert_response).and_raise(StandardError)
        _, errors = EventsJp::Connpass.get_events(limit: 100)
        expect(errors).not_to be_empty
      end
    end
  end
end
