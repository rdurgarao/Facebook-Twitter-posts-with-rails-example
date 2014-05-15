class TwitterController < ApplicationController
  # To change this template use File | Settings | File Templates.

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = "ZKEBLV5EOf1ZrkMYdywTg"
      config.consumer_secret = "TSA0p3PWLcxc7CVmNBHJbhtOaeKY13BygzONgDQeM"
      config.access_token = "1885443847-psGbfLD1vjvBsApR3N0WvRI28C7QgSggeFabaHi"
      config.access_token_secret = "66aqNIq1FTlgDKRTRh0ZHrSKrplQK4jKMBoKcsXzkGASU"
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
