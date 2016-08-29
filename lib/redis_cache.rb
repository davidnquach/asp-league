require 'redis'

class RedisCache < Redis
  def initialize(host: 'localhost', port: 6379)
    super(host: host, port: port)

    ping
  end

  def cache(key, options = {}, &block)
    value = get(key)

    unless value
      value = block.call

      set(key, value)
      expire(key, options.fetch(:expire)) if options.key? :expire
    end

    value
  end
end