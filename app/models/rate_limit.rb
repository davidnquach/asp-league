class RateLimit < ActiveRecord::Base
  validates :time, uniqueness: true, presence: true
  validates :requests, presence: true

  def self.buffer_limit?(time, requests, &block)
    rate_limit = find_by time: time

    return false if rate_limit.nil?

    if requests.to_i >= (rate_limit.requests * 0.8).to_i
      block.call if block_given?

      true
    else
      false
    end
  end
end
