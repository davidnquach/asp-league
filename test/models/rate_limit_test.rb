require 'test_helper'

class RateLimitTest < ActiveSupport::TestCase
  test 'buffer_limit returns true when requests are above 80%' do
    limit = 500
    partial_limit = (limit * 0.85).to_i

    assert RateLimit.buffer_limit?(600, partial_limit)
  end

  test 'buffer_limit returns true when requests are at 80%' do
    limit = 500
    partial_limit = (limit * 0.8).to_i

    assert RateLimit.buffer_limit?(600, partial_limit)
  end

  test 'buffer_limit returns false when requests are below 80%' do
    limit = 500
    partial_limit = (limit * 0.75).to_i

    assert_not RateLimit.buffer_limit?(600, partial_limit)
  end

  test 'buffer_limit returns true when requests are above 80% and a block is given' do
    limit = 500
    partial_limit = (limit * 0.85).to_i

    assert RateLimit.buffer_limit?(600, partial_limit) do
      'sleep'
    end
  end
end
