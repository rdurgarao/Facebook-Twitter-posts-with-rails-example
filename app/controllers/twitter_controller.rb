class TwitterController < ApplicationController
  # To change this template use File | Settings | File Templates.

  def initialize
    @client = Twitter::Client.new
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
