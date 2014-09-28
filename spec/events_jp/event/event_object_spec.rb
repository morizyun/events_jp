$:.unshift(File.expand_path('../', __FILE__))
require 'spec_helper'

describe 'EventsJp::EventObject' do
  describe '.finish_get?' do
    context 'achieve limit' do
      before(:each)  do
        response = %w(1 2)
        @result = EventsJp::EventObject.finish_get?(response, response, 2)
      end

      it 'return true' do
        expect(@result).to be(true)
      end
    end

    context 'get no response' do
      before(:each)  do
        response = %w(1)
        @result = EventsJp::EventObject.finish_get?(response, [], 2)
      end

      it 'return true' do
        expect(@result).to be(true)
      end
    end

    context 'not achieve limit' do
      before(:each)  do
        response = %w(1)
        @result = EventsJp::EventObject.finish_get?(response, response, 2)
      end

      it 'return false' do
        expect(@result).to be(false)
      end
    end
  end
end
