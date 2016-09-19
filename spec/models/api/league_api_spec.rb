require 'rails_helper'

RSpec.describe API::LeagueAPI, type: :api do
  let(:api) { API::LeagueAPI.new(host: 'localhost', version: '1') }

  describe '#get' do
    it 'returns the hash' do
      stub_request(:get, %r{/api/lol}).to_return(body: '{ "test": "value" }', status: 200)

      response = api.get(cache_key: 'test')
      expect(response).to be_a Hash
    end
  end
end