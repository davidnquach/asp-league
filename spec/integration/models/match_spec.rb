require 'rails_helper'
require_relative '../../../app/models/match_list'

WebMock.allow_net_connect!

describe MatchList do
  describe '#get_info' do
    let(:matchlist) { MatchList.new }

    context 'has redis cache' do
      it 'should return a hash' do
        allow($redis).to receive(:get).and_return('{ "test": "value" }')
        list = matchlist.get_info(summoner_id: 1)

        expect(list).to be_a Hash
      end
    end

    context 'no redis cache' do
      it 'should make a call to the api' do
        allow($redis).to receive(:get).and_return(nil)
        allow($redis).to receive(:set).and_return(nil)

        stub = stub_request(:get, /matchlist\/by-summoner/).to_return(body: '{ "test": "value" }')
        matchlist.get_info(summoner_id: 1)

        expect(stub).to have_been_requested
      end

      it 'should set the redis cache' do
        $redis.flushall

        matchlist.get_info(summoner_id: 21609871)

        expect($redis.get('matchlist:by-summoner:21609871')).not_to be nil
      end
    end
  end
end