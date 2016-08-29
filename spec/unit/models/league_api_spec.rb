require 'rails_helper'
require 'uri'
require_relative '../../../app/models/league_api'

describe LeagueAPI do
  describe '::new' do
    let(:api) { LeagueAPI.new(host: 'localhost', version: 'v3') }

    it 'should build a valid url' do
      expect(api.url).to match URI::regexp
    end
  end

  describe '#get' do
    let(:api) { LeagueAPI.new(host: 'na.api.pvp.net', version: 'v2.2') }

    it 'should make a request to the expected url' do
      stub = stub_request(:get, 'https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/1234?api_key=api-key')
      ENV['API_KEY'] = 'api-key'

      api.get('matchlist/by-summoner/1234')

      expect(stub).to have_been_requested
    end
  end
end