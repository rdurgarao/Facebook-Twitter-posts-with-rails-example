facebook-twitter-posts-in-rails-example
=======================================

This example is concentrating more on twitter and facebook integrations with rails.

Rails has many more gems to post, manage the social pages. I would like to discuss about facebook & twitter integrations.

## Posting to facebook pages

  For managing the pages and apps in facebook, we have to create an account in the facebook.
  Signup a facebook account with
  ` http://www.facebook.com `

  After creating the facebook account, create a page by using this link
  ``` https://www.facebook.com/pages/create ```

  we must login to facebook developers page to get access token
  ``` https://developers.facebook.com ```

### Facebook having graph explorer in facebook developers home page, from there you can get 2 hours acess token for facebook pages.


### If you need an 60 days facebook page access token
 - we need to create an facebook app
    for creating the app, go through
    `-> Apps -> Create a New App` in the facebook developers home page.
 - we have to configure an app to facebook page.
 - In the App home page, find out AppId and AppSecret
 - by using the app_id, make a request to following address
  ```ruby
  https://www.facebook.com/dialog/pagetab?app_id=745040398850519&display=popup&next=http://www.facebook.com
  ```
 - It displays popup, select which page you want to manage it.
 - then you make a request to get an 60 days token

    ```ruby
    GET /oauth/access_token?
            grant_type=fb_exchange_token&
            client_id={app-id}&
            client_secret={app-secret}&
            fb_exchange_token={short-lived-token}
    ```

    - Example link:
    ```ruby
     https://graph.facebook.com/oauth/access_token?client_id=745040398850519&client_secret=653d6a471ea9deded7bddfc52c1642fb&grant_type=fb_exchange_token&fb_exchange_token=CAAKlnDxRGdcBAPFw25K59XoAF6ZBm3FpNAZABqI6mQYAudH8XCnt4ZCB0gN7vR3pahx25gu1jp9jARwIqReUBYfnPL8QNho1neCyQeRR0t4AElurhVhRLS9Sgmldo6o1bI1AFOGedb4JVDDZCCRDBaZC6jEqWZChrKTrzhpZCrBwqNkkRTNJ1RXStCnmIVfB0UZD
     ```

### Using Koala gem to post facebook wall posts

  - require gem into Gemfile
    ``` gem 'koala' ```
  - by using the access token, we pick facebook graph object from koala
     ```ruby
     #Picking the graph api object from kaola gem
     @graph = Koala::Facebook::API.new(@access_token)
     ```
  - In koala gem ,we have so many methods to manage, post to facebook.
    ```ruby
       #put_wall_post is method to post an article to the pages
           post_info = @graph.put_wall_post(title, {
             name: link_name, description: description, picture: image_url, link: page_link
           })
     ```

## Example App to Start Testing Facebook Post with Koala gem
- we spend a lot of time on posting to facebook, we think to design an app to make it easier with rails.

### Just Clone this example app
 ```ruby
  git clone https://github.com/rdurgarao/facebook-twitter-posts-in-rails-example.git
  ```

### Start the app using rails server
 - It started on rails 3000 port
 ``` rails server ```

##### Make a request to `http://localhost:3000/facebook_wall_post`
  - It displays a form with facebook fields as shown
  - place an access token in the input field or else configure it in facebook controller initializer block '-> app -> controllers -> facebook_controller -> initialize block'
  ```ruby
   def initialize
          #specify access_token here
          @access_token = 'X'
        end
  ```
  - Post your article by clicking on post button
  - you get success response or exception thrown by facebook or kaola gem
    More about [exceptions](http://rubydoc.info/gems/koala/1.9.0/Koala/Facebook/APIError)

