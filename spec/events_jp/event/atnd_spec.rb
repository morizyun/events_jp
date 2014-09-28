$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Atnd' do
  describe '.convert_response' do
    before(:each)  do
      response = %[{"events": [{"event": {"address": "sample"}}]}]
      @conv_res = EventsJp::Atnd.convert_response(response)
    end

    it 'converts to Array' do
      expect(@conv_res.class).to eq(Array)
      expect(@conv_res.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      before(:each) do
        @res = EventsJp::Atnd.get_events(limit: 100, keyword: 'Ruby')
      end

      it 'returns conpass API results' do
        expect(@res.count).to eq(100)
        expect(@res.first.title).to eq('第16回 tottoruby')
      end
    end

    context 'no keyword' do
      before(:each) do
        @res = EventsJp::Atnd.get_events(limit: 200)
      end

      it 'returns conpass API results' do
        expect(@res.count).to eq(200)
        expect(@res.first.curator).to eq('atnd')
        expect(@res.first.title).to eq('[テスト] qkstudy #01')
        expect(@res.first.catch).to eq('人は働くために、休みが必要である。')
        expect(@res.first.event_url).to eq('http://atnd.org/events/17662')
        expect(@res.first.started_at).to eq('2112-08-20T19:00:00.000+09:00')
        expect(@res.first.ended_at).to eq('2112-08-20T21:30:00.000+09:00')
        expect(@res.first.address).to eq('東京都千代田区丸の内3丁目5番1号')
        expect(@res.first.place).to eq('東京国際フォーラム　ホールB7')
        expect(@res.first.lat).to eq('35.6769467')
        expect(@res.first.lon).to eq('139.7635034')
        expect(@res.first.limit).to be_nil
        expect(@res.first.accepted).to eq(5)
        expect(@res.first.waiting).to eq(0)
      end
    end
  end
end
