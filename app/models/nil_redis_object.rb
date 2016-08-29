class NilRedisObject
  def cache(_, _ = {}, &block)
    block.call
  end
end