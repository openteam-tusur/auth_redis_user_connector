require 'redis'

class RedisUserConnector
  def self.connect(hash)
    raise "#{name}: Could not establish connection" if hash.nil? || hash.empty?

    @connect = hash
  end

  def self.get(key)
    connection.hgetall("#{namespace}:#{key}")
  end

  def self.set(key, *attrs)
    connection.hmset("#{namespace}:#{key}", *(attrs.flatten))
  end

  private

  def self.connect_options
    @connect.merge :driver => :hiredis
  end

  def self.connection
    @connection ||= Redis.new(connect_options)
  end

  def self.namespace
    'user'
  end
end
