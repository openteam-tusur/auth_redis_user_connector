require 'redis'

class RedisUserConnector
  def self.connect(hash)
    @connect = hash
  end

  def self.get(key)
    connection.hgetall("#{namespace}:#{key}")
  end

  def self.set(key, *attrs)
    connection.hmset("#{namespace}:#{key}", *(attrs.flatten))
  end

  private

  def self.connection
    @connection ||= Redis.new(@connect.merge(:driver => :hiredis))
  end

  def self.namespace
    'user'
  end
end
