require 'rails_helper'

RSpec.describe RateLimit, type: :model do
  describe '#buffer_limit' do
    it 'returns true when limit is about 80%' do
      limit = 500
      partial_limit = (limit * 0.85).to_i

      expect(RateLimit.buffer_limit?(600, partial_limit)).to eq true
    end
  end
end
