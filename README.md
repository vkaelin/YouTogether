# YouTogether
[Link to the website](https://youtogether.herokuapp.com/)

## Front end
The app has many real-time features. I used ActionCable for two major things:
1. The chat rooms and messages
2. The control of the YouTube player

Furthermore, I used AJAX in 2 situations:
1. Delete a room
2. Delete a Favorite video

## Data structures and models
**User**
* Has and belongs to many rooms
* Has many messages
* Has many favorite videos
* Has a secure password attribute with bcrypt gem
* Has a unique email attribute
* Has a mount uploader avatar, AvatarUploader from carrierwave gem
* Has a role (admin or registered by default)
* Has many owned rooms

**Room**
* Has and belongs to many users
* Has many messages
* Has a name attribute
* Belongs to a user (room's owner)

**Message**
* Belongs to room
* Belongs to user

**Favorite Video**
* Belongs to user

**Room_user**
* Join table between room and user

## Third party services
**-> Ruby gems**
* gem 'bcrypt' User password management
* gem 'kaminari' Page system for the rooms and the favorite videos
* gem 'carrierwave', '~> 1.1.0' Upload image for avatar
* gem 'figaro' Secure config data when deploying on Heroku
* gem 'fog-aws' Carrierwave communicate with AWS S3
* gem 'redis' Redis to use ActionCable on production
* gem 'pg' PostgreSQL database for production

**-> CSS "frameworks"**
* Normalize.css [Link](https://github.com/necolas/normalize.css) To help with the default css looks on every browser
* Bootstrap 4 Grid: [Link to github file](https://github.com/twbs/bootstrap/blob/v4-dev/dist/css/bootstrap-grid.css)
* [Font Awesome](https://fontawesome.com/), add svg icons to our app easily

**-> Third party APIs**
* YouTube API, to create and control the player
* Amazon Web Services S3, Cloud Storage Service to upload users' avatars

**-> Deployment services**
* Heroku, deploy our app in production
* Redis To Go Heroku's Add-on to create the Redis database

## Difficulties I met
**SCSS**

I found the curved mask on [Codepen](https://codepen.io/doubletake/pen/NMYvym) and I really liked it. But it was pretty hard to use it, especially in the footer. But I am happy with the final render.

**JS**

ActionCable was very strange for me at the beginning. There is a lot of steps going on.
In addition, passing the URL of the video from the controller to the JS was not very intuitive: I made it with a hidden HTML tag but I still don't really know if it is the best way.
To finish, the YouTube player API was a little difficult to use, especially with the mobile. We can't interact with the player on mobile (can't force to play a video if the user has not loaded his player yet).

**Ruby**

At first, the fact that the rooms have to have 2 different user(s)  was a little disturbing for me.

**Tests**

The system tests were literally a pain. At first, the i18n params locale was not included so I had to give a hash to every path helpers. Secondly, if I put the "fonts" folder as a sibling to "images" folder, the tests activated an error message (can't find the fonts). Even with the line: "config.assets.paths << Rails.root.join("app", "assets", "fonts")" in my application.rb file. To make it works, I had to put the fonts folder inside the images folder again and uses relatives paths.

**Deploying to production**

Deploying ActionCable application on Heroku was a mess at the beginning. Luckily, I found an [amazing tutorial](https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable) and it works like a charm.

## Conclusion
I am happy with my final application. I am just a little disappointed with the YouTube player on mobile. The app is not really a pleasure to use on mobile because of that.
