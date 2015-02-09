namespace = "kalading_web:weixin_authorize"
redis = Redis.new(:host => "127.0.0.1", :port => "6379", :db => 15)

exist_keys = redis.keys("#{namespace}:*")
exist_keys.each{|key|redis.del(key)}

redis = Redis::Namespace.new("#{namespace}", :redis => redis)

WeixinAuthorize.configure do |config|
  config.redis = redis
end
