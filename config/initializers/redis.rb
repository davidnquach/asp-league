require_relative '../../lib/redis_cache'
require_relative '../../lib/nil_redis_object'

@tries = 1

def try_redis
  RedisCache.new
rescue Redis::CannotConnectError
  while @tries < 3
    @tries += 1
    sleep 1
    if (r = try_redis)
      return r
    end
  end

  NilRedisObject.new
end

$redis = try_redis