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

  def self.pub(channel, message)
    pubsub_connection.publish(channel, message)
  end

  def self.sub(channel, &block)
    pubsub_connection.subscribe(channel, &block)
  end

  private

  def self.connect_options
    raise "#{name}: Could not establish connection" if @connect.nil? || @connect.empty?

    @connect.merge :driver => :hiredis
  end

  def self.connection
    @connection ||= Redis.new(connect_options)
  end

  def self.pubsub_connection
    @pubsub_connection ||= Redis.new(connect_options)
  end

  def self.namespace
    'user'
  end
end
