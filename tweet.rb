#coding: utf-8
require 'rubygems'
require 'twitter'
require 'gmail'

USERNAME='************@gmail.com' #gmailのアドレス
PASSWORD='************' #gmailのパスワード

class Tweet
  attr_accessor :tweet
  def initialize
    @cli = Twitter::REST::Client.new do |config|
      config.consumer_key       = '************************'
      config.consumer_secret    = '************************'
      config.access_token        = '************-************************'
      config.access_token_secret = '************************************'
    end
    @tweet = make_tweet
  end

  def make_tweet   
    gmail = Gmail.new(USERNAME,PASSWORD)
    tweet = nil
    mails =  gmail.inbox.emails(:unread,:on => Date.today).each do |mail| #emailsの引数には:all,:read,:unreadがある
      if mail.message.to.include?("************@************.com")
        time = Time.parse(mail.message.date.to_s)
        time_tweet = time.strftime("%m月%d日%H:%M")
        tweet = "#{time_tweet}に新規メーリスが投稿されました！ご確認ください。"
#        mail.read!
      end
    end
    gmail.logout
    return tweet
  end

  def test
    t = Time.now.to_s
    update(t)
  end

  def alert
    update(@tweet)
  end
  
  private
  def update(tweet)
    return nil unless tweet
    begin
      @cli.update(tweet.chomp)
    rescue => ex
      nil
    end
  end
end