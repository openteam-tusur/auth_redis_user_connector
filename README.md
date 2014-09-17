# AuthRedisUserConnector

Simple interface for http://redis.io/commands/hgetall and http://redis.io/commands/hmset

## Installation

Add this line to your application's Gemfile:

    gem 'auth_redis_user_connector'


## Usage

```code
RedisUserConnector.connect :url => 'redis://localhost:6379/1'

RedisUserConnector.set 'mykey', 'field1', 'value1', 'field2', 'value2'
RedisUserConnector.get 'mykey'
```
