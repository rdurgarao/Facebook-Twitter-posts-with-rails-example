Facebook-Twitter-posts-with-rails-example
=======================================

This example is concentrating more on twitter and facebook integrations with rails.

Rails has many more gems to post, manage the social pages. I would like to discuss about facebook & twitter integrations.

### Posting to facebook pages

  For managing the pages and apps in facebook, we have to create an account in the facebook.
  Signup a facebook account with
  ` http://www.facebook.com `

  After creating the facebook account, create a page by using this link
  ```ruby
     https://www.facebook.com/pages/create
  ```

  ![alt create-page](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/create_fb_page.png)

  we must login to facebook developers page to get access token
  ```ruby
     https://developers.facebook.com
  ```

#### Facebook having graph explorer in facebook developers home page, from there you can get 2 hours acess token for facebook pages.

- Select Application from the drop down in graph explorer tools, and select the get access token button, it prompt for permissions, select basic permissions and generate short access token.

  ```ruby
     https://developers.facebook.com/tools/explorer
  ```

  ![alt 2-hours-fb-token](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/short_token.png)
  ![alt 2-hours-fb-token](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/short_token_permissions.png)

#### If you need an 60 days facebook page access token

 - We need to create an facebook app, for creating the app, go through
    `-> Apps -> Create a New App` in the facebook developers home page

    ![alt create-app](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/create_app.png)
    ![alt create-app-dialog](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/create_app_dialog.png)

 - In the process of managing pages through the app, we need App ID & App Secret.

    ![alt app-id](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/fb_app_id.png)

 - By using the AppID, make a request to following address

    *note:* The loggedin user must be manage his own pages through dialog box.

  ```ruby
     https://www.facebook.com/dialog/pagetab?app_id=746040337858519&display=popup&next=http://www.facebook.com
  ```

 - It displays popup, select which page you want to manage it

    ![alt manage-page-apps](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/manage_page_apps.png)

 - Then you make a request to get an 60 days token

    ```ruby
       GET /oauth/access_token?
            grant_type=fb_exchange_token&
            client_id={app-id}&
            client_secret={app-secret}&
            fb_exchange_token={short-lived-token}
    ```

    - Example link:

    ```ruby
       https://graph.facebook.com/oauth/access_token?client_id=749040378850589&client_secret=650d69481ea9deded7bddfc02816c2fb&grant_type=fb_exchange_token&fb_exchange_token=CAAKlnDxRGdcBAPFw25K59XoAF6ZBm3FpNAZABqI6mQYAudH8XCnt4ZCB0gN7vR3pahx25gu1jp9jARwfIqReUdBYfnPL8QNhso1neCfyQeRR0t4AElurhVhRo6o1bI1AFOGedb4JVDDZCCRDfBafZC6jEsqWZCdhrKTrzhpZCrBwqNkkRTNJ1RXStCnmIVfB0UZD
     ```

    Response should like this
    ```ruby
      access_token=CAAKlnDxRGdcBAI4gH2wJaFwjeeqEn3m0v1vGRlT8sP6cUKKwGp5oTokKrR8NerUw4PRSbxQltvZB6bFZBCbeEu1l0VYeraYxMZB81y24AiEapoaw7URZBe4Pz6WGL1ZCfdA1ZC8ThTK112TRvbQv7EyuJdItXH1bKtcIy2lrIV8t4Lt7lZCEgiZA&expires=5162446
    ```

#### Using Koala gem to post facebook wall posts

  - Require [koala](https://github.com/arsduo/koala) gem into Gemfile

    ``` gem 'koala' ```

  - By using the access token, we pick facebook graph object from koala

     ```ruby
        #Picking the graph api object from kaola gem
        @graph = Koala::Facebook::API.new(@access_token)
     ```

  - In koala gem ,we have methods to manage posts in facebook. so below snippet is for [wall post](http://rubydoc.info/gems/koala/1.9.0/Koala/Facebook/GraphAPIMethods#put_wall_post-instance_method)

      ```ruby
         #put_wall_post is method to post an article to the pages
          post_info = @graph.put_wall_post(post_title, {
          name: link_name, description: post_description, picture: image_url, link: page_link
        })
      ```

### Twetting to twitter pages with twitter client

  - At first, we have an twitter account to manage the tweets.
    for signup an account `https://twitter.com/signup`

  - Ruby [twitter](http://sferik.github.io/twitter/) gem to manage twitter accounts
    ``` gem 'twitter' ```

  - Managing the twitter accounts using OAuth based protocol,
    we need a privilliges to access twitter account, so for that we have to create an twitter app using [twitter developers site](https://dev.twitter.com/)

    Creating Twitter App

    ```
      https://apps.twitter.com/app/new
    ```

  - Displaying the apps

    ```
    https://apps.twitter.com/
    ```

  - Select an API Keys tab in home page of app, generate a new access token

  - Configure twitter client

    ```ruby
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "YOUR_CONSUMER_KEY"
        config.consumer_secret     = "YOUR_CONSUMER_SECRET"
        config.access_token        = "YOUR_ACCESS_TOKEN"
        config.access_token_secret = "YOUR_ACCESS_SECRET"
      end
    ```

  - Using client object, post a tweet like this

    ```ruby
      @client.update('First tweet')
    ```
    *note:* Twitter accept the tweet less than 140 characters, twitter need write permissioned access token for posting the tweet.
    for more about [Twitter methods](http://rdoc.info/gems/twitter#Usage_Examples)


### Example App to Start Testing Facebook Post with Koala gem
- We spend a lot of time on posting to facebook, We think to design an sample app to make it easier facebook integrations with rails.

#### Just Clone this example app
 ```ruby
    git clone https://github.com/rdurgarao/facebook-twitter-posts-in-rails-example.git
  ```

#### Start the app using rails server
 It started on rails 3000 port

  ``` rails server ```

##### Make a request to `http://localhost:3000`


- Facebook wall Post

  - It displays a form with facebook fields as shown
    ![alt sample-wallpost-form](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/social_wall_post_form.png)

  - Place an access token in the input field, else configure it in facebook controller initializer block ` -> app -> controllers -> facebook_controller -> initialize block `

  ```ruby
     def initialize
          #specify access_token here
          @access_token = 'X'
     end
  ```
  - Post your article by clicking on post button

  - After succesfull posting an article, you get success response, else exception thrown by facebook or koala gem
    , More about [exceptions](http://rubydoc.info/gems/koala/1.9.0/Koala/Facebook/APIError)

  - Finally, the posted article in the facebook.

   ![alt posted-article](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/posted_article.png)


- Twitter tweet

  - Configure Twitter client in ` app -> controllers -> twitter_controller.rb -> initiliaze method config params`

    ```ruby
      @client = Twitter::REST::Client.new do |config|
            config.consumer_key = "ZKMBsV5ETf1erkMYdywTg"
            config.consumer_secret = "TsA0p3PWLcxc7CVmNBHJbhsOaeKs13BygsONgDQeM"
            config.access_token = "1835423847-psdbfLDsvjvBsApR3t0WvRI28C7QgStgeFabaHi"
            config.access_token_secret = "66aqNIqsFTlgDKRTdh0ZHrSKrplQKdjKMBodcsXzkGASU"
      end
    ```

  - Restart the server, if its already running

  - Make a request to `localhost:3000`

  - Placed a tweet in text area and click on tweet button

    ![alt tweet-article](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/master/public/facebook_images/tweet_view.png)

  - It displays success response or else exception message

  - Tweeted message is like this

    ![alt tweet-posted](https://raw.githubusercontent.com/rdurgarao/facebook-twitter-posts-in-rails-example/social-integrations/public/facebook_images/tweet_response.png)
