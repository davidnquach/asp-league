require 'redis_cache'
require_relative '../../app/models/nil_redis_object'

$redis = begin
  RedisCache.new
rescue Redis::CannotConnectError
  NilRedisObject.new
end