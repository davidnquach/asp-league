class RedisController < ApplicationController
  def retry
    @tries = 3
    $redis = try_redis

    redirect_back fallback_location: root_url
  end
end
