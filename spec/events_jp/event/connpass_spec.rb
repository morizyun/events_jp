$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Conpass' do
  describe '.convert_response' do
    before(:each)  do
      response = %[{"events": [{"address": "sample"}]}]
      @conv_res = EventsJp::Connpass.convert_response(response)
    end

    it 'converts to Array' do
      expect(@conv_res.class).to eq(Array)
      expect(@conv_res.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    context 'with keyword' do
      before(:each) do
        @res = EventsJp::Connpass.get_events(keyword: 'Ruby', limit: 100)
      end

      it 'returns conpass API results' do
        expect(@res.count).to eq(100)
        expect(@res.first.title).to eq('NDS#39 Niigata.pm tech talk')
      end
    end

    context 'no keyword' do
      before(:each) do
        @res = EventsJp::Connpass.get_events(limit: 100)
      end

      it 'returns conpass API results' do
        expect(@res.count).to eq(100)
        expect(@res.first.service).to eq('connpass')
        expect(@res.first.title).to eq('キイロイトリ勉強会')
        expect(@res.first.catch).to eq('キイロイトリの魅力を勉強してください')
        expect(@res.first.event_url).to eq('http://connpass.com/event/14/')
        expect(@res.first.started_at).to eq(DateTime.parse('2038-01-18T03:13:10+09:00'))
        expect(@res.first.ended_at).to eq(DateTime.parse('2038-01-18T03:14:10+09:00'))
        expect(@res.first.address).to eq('東京')
        expect(@res.first.place).to eq('どこか')
        expect(@res.first.lat).to eq(35.6894875)
        expect(@res.first.lon).to eq(139.6917064)
        expect(@res.first.limit).to eq(10)
        expect(@res.first.accepted).to eq(2)
        expect(@res.first.waiting).to eq(0)
      end
    end
  end
end
