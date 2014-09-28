$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Zusaar' do
  describe '.convert_response' do
    before(:each)  do
      response = %[{"event":[{"address":"sample"}]}]
      @conv_res = EventsJp::Zusaar.convert_response(response)
    end

    it 'converts to Array' do
      expect(@conv_res.class).to eq(Array)
      expect(@conv_res.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      before(:each) do
        @res = EventsJp::Zusaar.get_events(keyword: 'Ruby', limit: 10)
      end

      it 'returns conpass API results' do
        expect(@res.count).to eq(10)
        expect(@res.first.title).to eq('もくもくRuby')
      end
    end

    context 'no keyword' do
      before(:each) do
        @res = EventsJp::Zusaar.get_events(limit: 200)
      end

      it 'returns zusaar API results' do
        expect(@res.count).to eq(200)
        expect(@res.first.curator).to eq('zusaar')
        expect(@res.first.title).to eq('イスラム＆ハラル市場進出支援セミナー')
        expect(@res.first.catch).to eq('〜本当は教えたくない東南アジア”イスラム市場”のビジネスチャンス〜')
        expect(@res.first.event_url).to eq('http://www.zusaar.com/event/7667004')
        expect(@res.first.started_at).to eq('2014-10-11T13:30:00+09:00')
        expect(@res.first.ended_at).to eq('2014-10-11T15:30:00+09:00')
        expect(@res.first.address).to eq('東京都千代田区神田鍛冶町3-2-2')
        expect(@res.first.place).to eq('エッサム神田ホール')
        expect(@res.first.lat).to eq(35.6934894)
        expect(@res.first.lon).to eq(139.7712663)
        expect(@res.first.limit).to eq(30)
        expect(@res.first.accepted).to eq(0)
        expect(@res.first.waiting).to eq(0)
      end
    end
  end
end
