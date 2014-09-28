$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::Doorkeeper' do
  describe '.convert_response' do
    before(:each)  do
      response = %[[{"event":{"address": "sample"}}]]
      @conv_res = EventsJp::Doorkeeper.convert_response(response)
    end

    it 'converts to Array' do
      expect(@conv_res.class).to eq(Array)
      expect(@conv_res.first.address).to eq('sample')
    end
  end

  describe '.get_events' do
    before(:each) do
      @res = EventsJp::Doorkeeper.get_events(limit: 50)
    end

    it 'returns doorkeeper API results' do
      expect(@res.count).to eq(50)
      expect(@res.first.service).to eq('doorkeeper')
      expect(@res.first.catch).to be_nil
      expect(@res.first.title).to eq('大切な人の未来へ贈る　タイムカプセルレター(2017年に再会！アースデイ東京2014企画プロジェクト版)')
      expect(@res.first.event_url).to eq('http://asobiba.doorkeeper.jp/events/10448')
      expect(@res.first.started_at).to eq(DateTime.parse('2017-04-30T00:00:00.000Z'))
      expect(@res.first.ended_at).to eq(DateTime.parse('2017-04-30T01:00:00.000Z'))
      expect(@res.first.address).to be_nil
      expect(@res.first.place).to be_nil
      expect(@res.first.lat).to be_nil
      expect(@res.first.lon).to be_nil
      expect(@res.first.limit).to eq(500)
      expect(@res.first.accepted).to eq(115)
      expect(@res.first.waiting).to eq(0)
    end
  end
end
