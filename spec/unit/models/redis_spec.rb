require 'rails_helper'
require_relative '../../../lib/redis_cache'

describe RedisCache do
  describe '#set' do
    let(:redis) { RedisCache.new }

    it 'should set the value for the key' do
      redis.set('test', 'value')

      expect(redis.get('test')).to eq 'value'
    end
  end
end