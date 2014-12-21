$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Zusaar' do
  describe '.convert_response' do
    let!(:response) { %[{"event":[{"address":"sample"}]}] }
    it 'converts to Array' do
      results = EventsJp::Zusaar.convert_response(response)
      expect(results.class).to eq(Array)
      expect(results.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      it 'returns conpass API results' do
        results, errors = EventsJp::Zusaar.get_events(keyword: 'Ruby', limit: 10)
        expect(errors).to be == []
        expect(results.count).to eq(10)
        expect(results.first.title).to eq('もくもくRuby')
      end
    end

    context 'no keyword' do
      it 'returns zusaar API results' do
        results, errors = EventsJp::Zusaar.get_events(limit: 100)
        expect(errors).to be == []
        expect(results.count).to eq(100)
        expect(results.first.service).to eq('zusaar')
        expect(results.first.title).to eq('イスラム＆ハラル市場進出支援セミナー')
        expect(results.first.catch).to eq('〜本当は教えたくない東南アジア”イスラム市場”のビジネスチャンス〜')
        expect(results.first.event_url).to eq('http://www.zusaar.com/event/7667004')
        expect(results.first.started_at).to eq(DateTime.parse('2014-10-11T13:30:00+09:00'))
        expect(results.first.ended_at).to eq(DateTime.parse('2014-10-11T15:30:00+09:00'))
        expect(results.first.address).to eq('東京都千代田区神田鍛冶町3-2-2')
        expect(results.first.place).to eq('エッサム神田ホール')
        expect(results.first.lat).to eq(35.6934894)
        expect(results.first.lon).to eq(139.7712663)
        expect(results.first.limit).to eq(30)
        expect(results.first.accepted).to eq(0)
        expect(results.first.waiting).to eq(0)
      end
    end

    context 'when raise errors in convert_response method' do
      it 'returns error' do
        allow(EventsJp::Zusaar).to receive(:convert_response).and_raise(StandardError)
        _, errors = EventsJp::Zusaar.get_events(limit: 100)
        expect(errors).not_to be_empty
      end
    end
  end
end
