class FacebookController < ApplicationController

  def initialize
    #specify access_token here
    @access_token = 'X'
  end

  def page_wall_post
    @access_token = params[:access_token].present? ? params[:access_token] : @access_token
    title = params[:title]
    page_link = params[:page_link]
    link_name = params[:link_name]
    description = params[:description]
    image_url = params[:image_url]
    success_msg = 'Article Posted'


    #Picking the graph api object from kaola gem
    @graph = Koala::Facebook::API.new(@access_token)

    begin
      #put_wall_post is method to post an article to the pages
      post_info = @graph.put_wall_post(title, {
        name: link_name, description: description, picture: image_url, link: page_link
      })
    rescue Exception => e
     success_msg =  e.message
    end

    render text: success_msg
  end

  def index
    render 'facebook_post.html.erb'
  end
end
