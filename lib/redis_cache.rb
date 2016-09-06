require 'redis'

class RedisCache < Redis
  def initialize
    super

    ping
  end

  def cache(key, options = {}, &block)
    value = get(key)

    if value.nil?
      value = block.call

      set(key, value)
      expire(key, options.fetch(:expire)) if options.key? :expire
    end

    value
  end
end