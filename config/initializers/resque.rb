require 'resque/server'
require 'uri'
if Rails.env.development? || Rails.env.test?
  Resque.redis = Redis.new(:host => 'localhost', :port => '6379')
else
  uri = URI.parse(ENV['REDISTOGO_URL'])
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

  Resque.redis = REDIS
end
#
# if Rails.env.production?
#   uri = URI.parse(ENV['REDIS_URL'])
# else
#   uri = URI.parse("redis://localhost:6379/")
# end
# Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
# Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }