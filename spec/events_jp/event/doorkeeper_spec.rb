$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Doorkeeper' do
  describe '.convert_response' do
    let!(:response) { %[[{"event":{"address": "sample"}}]] }
    it 'converts to Array' do
      results = EventsJp::Doorkeeper.convert_response(response)
      expect(results.class).to eq(Array)
      expect(results.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    it 'returns doorkeeper API results' do
      results, errors = EventsJp::Doorkeeper.get_events(limit: 25)
      expect(errors).to be == []
      expect(results.count).to eq(25)
      expect(results.first.service).to eq('doorkeeper')
      expect(results.first.catch).to be_nil
      expect(results.first.title).to eq('大切な人の未来へ贈る　タイムカプセルレター(2017年に再会！アースデイ東京2014企画プロジェクト版)')
      expect(results.first.event_url).to eq('http://asobiba.doorkeeper.jp/events/10448')
      expect(results.first.started_at).to eq(DateTime.parse('2017-04-30T00:00:00.000Z'))
      expect(results.first.ended_at).to eq(DateTime.parse('2017-04-30T01:00:00.000Z'))
      expect(results.first.address).to be_nil
      expect(results.first.place).to be_nil
      expect(results.first.lat).to be_nil
      expect(results.first.lon).to be_nil
      expect(results.first.limit).to eq(500)
      expect(results.first.accepted).to eq(115)
      expect(results.first.waiting).to eq(0)
    end
  end

  context 'when raise errors in convert_response method' do
    it 'returns error' do
      allow(EventsJp::Doorkeeper).to receive(:convert_response).and_raise(StandardError)
      _, errors = EventsJp::Doorkeeper.get_events(limit: 100)
      expect(errors).not_to be_empty
    end
  end
end
