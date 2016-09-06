class NilRedisObject
  def ping
    nil
  end

  def get(_)
    nil
  end

  def set(_)
  end

  def cache(_, _ = {}, &block)
    block.call
  end
end