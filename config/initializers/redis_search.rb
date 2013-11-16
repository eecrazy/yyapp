require "redis"
require "redis-namespace"
require "redis-search"
App.new
redis = Redis.new(:host => Setting.host ,:port => "6379")
redis.select(3)
# don't forget change the namespace
redis = Redis::Namespace.new("yyapp:redis_search", :redis => redis)
Redis::Search.configure do |config|
  config.redis = redis
  config.complete_max_length = 50
  config.pinyin_match = true
end
