require 'rubygems'
require './tweet.rb'
require 'clockwork'
include Clockwork

every(3.minute, 'frequent_job') do
	Tweet.new.alert
end
