require 'redis'

class RedisUserConnector
  def self.get(key)
    connection.hgetall("#{namespace}:#{key}")
  end

  def self.set(key, *attrs)
    connection.hmset("#{namespace}:#{key}", *(attrs.flatten))
  end

  def self.clean(key, field)
    connection.hdel("#{namespace}:#{key}", field)
  end

  def self.pub(channel, message)
    pubsub_connection.publish(channel, message)
  end

  def self.sub(channel, &block)
    pubsub_connection.subscribe(channel, &block)
  end

  private

  def self.connect_options
    connect_options = Settings['redis_user_connector']

    raise "Error::Settings: <redis_user_connector> is undefined" if connect_options.nil? || connect_options.empty?

    connect_options.merge :driver => :hiredis
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
