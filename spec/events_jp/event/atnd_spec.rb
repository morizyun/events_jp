require 'spec_helper'

describe 'EventsJp::Atnd' do
  describe '.convert_response' do
    let!(:response) { %[{"events": [{"event": {"address": "sample"}}]}] }
    it 'converts to Array' do
      results = EventsJp::Atnd.convert_response(response)
      expect(results.class).to eq(Array)
      expect(results.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      it 'returns conpass API results' do
        results, errors = EventsJp::Atnd.get_events(limit: 100, keyword: 'Ruby')
        expect(errors).to be == []
        expect(results.count).to eq(100)
        expect(results.first.title).to eq('第16回 tottoruby')
      end
    end

    context 'no keyword' do
      it 'returns conpass API results' do
        results, errors = EventsJp::Atnd.get_events(limit: 100)
        expect(errors).to be == []
        expect(results.count).to eq(100)
        expect(results.first.service).to eq('atnd')
        expect(results.first.title).to eq('[テスト] qkstudy #01')
        expect(results.first.catch).to eq('人は働くために、休みが必要である。')
        expect(results.first.event_url).to eq('http://atnd.org/events/17662')
        expect(results.first.started_at).to eq(DateTime.parse('2112-08-20T19:00:00.000+09:00'))
        expect(results.first.ended_at).to eq(DateTime.parse('2112-08-20T21:30:00.000+09:00'))
        expect(results.first.address).to eq('東京都千代田区丸の内3丁目5番1号')
        expect(results.first.place).to eq('東京国際フォーラム　ホールB7')
        expect(results.first.lat).to eq(35.6769467)
        expect(results.first.lon).to eq(139.7635034)
        expect(results.first.limit).to be_nil
        expect(results.first.accepted).to eq(5)
        expect(results.first.waiting).to eq(0)
      end
    end

    context 'when raise errors in convert_response method' do
      it 'returns error' do
        allow(EventsJp::Atnd).to receive(:convert_response).and_raise(StandardError)
        _, errors = EventsJp::Atnd.get_events(limit: 100)
        expect(errors).not_to be_empty
      end
    end
  end
end
