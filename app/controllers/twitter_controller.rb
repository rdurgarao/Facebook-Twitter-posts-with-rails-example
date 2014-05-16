class TwitterController < ApplicationController
  # To change this template use File | Settings | File Templates.

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "xx"
      config.consumer_secret = "xx"
      config.access_token = "xx-xx"
      config.access_token_secret = "xx"
    end
  end

  def tweet_post
    tweet = params[:tweet]
    message = 'Tweet posted sucessfully'

    begin
      @client.update(tweet)
    rescue Exception => e
      message = e.message
    end

    render text: message
  end
end
