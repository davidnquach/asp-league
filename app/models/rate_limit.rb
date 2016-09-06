class RateLimit < ActiveRecord::Base
  validates :time, uniqueness: true

  def self.buffer_limit?(time, requests, &block)
    rate_limit = find_by time: time

    if requests == (rate_limit.requests * 0.8).to_i
      return block.call if block_given?

      true
    else
      false
    end
  end
end
