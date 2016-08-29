require 'rails_helper'
require_relative '../../../app/models/match_list'

describe MatchList do
  describe '#get_info' do
    context 'the request has not been cached yet' do
      let(:matchlist) { MatchList.new }

      it 'should make a request to get the match list' do
        stub = stub_request(:get, 'https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/1?api_key=api-key')
        ENV['API_KEY'] = 'api-key'

        allow($redis).to receive(:get).and_return(nil)
        allow(JSON).to receive(:parse).and_return('')

        matchlist.get_info(summoner_id: 1)

        expect(stub).to have_been_requested
      end
    end

    context 'the request has been cached' do
      let(:matchlist) { MatchList.new }

      it 'should not make a request to get the match list' do
        stub = stub_request(:get, 'https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/1234?api_key=api-key')
        ENV['API_KEY'] = 'api-key'

        allow($redis).to receive(:get).and_return('{"tests": "value"}')

        matchlist.get_info(summoner_id: 1)

        expect(stub).to_not have_been_requested
      end
    end
  end
end
