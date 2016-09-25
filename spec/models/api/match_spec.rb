require 'rails_helper'

RSpec.describe API::Match, type: :api do
  let(:match_details) do
    {
        timestamp: 1470982276212,
        champion: 62,
        region: 'NA',
        queue: 'RANKED_TEAM_5x5',
        season: 'SEASON2016',
        matchId: 2264819718,
        role: 'SOLO',
        platformId: 'NA1',
        lane: 'TOP'
    }
  end

  let(:match) { API::Match.new 2264819718 }
  let(:details) { File.read(File.join(SUPPORT_FOLDER, 'match_details.json')) }

  describe '::details' do
    it 'returns the match class' do
      stub_request(:get, %r{/api/lol}).to_return(body: details)
      match = API::Match.details(match_details)

      expect(match).to be_a API::Match
    end
  end

  describe '#info' do
    it 'should make a call to the api' do
      stub = stub_request(:get, %r{na.api.pvp.net/api/lol/na/v2.2/}).to_return(body: details)

      match.info

      expect(stub).to have_been_requested
    end
  end

  describe '#find_participant' do
    it 'should return the correct participant' do
      stub_request(:get, %r{/api/lol}).to_return(body: details)
      match = API::Match.details(match_details)

      participant = match.participant(40981919)

      expect(participant).not_to be nil
    end
  end
end