# Favimarks

Favimarks is a Rails project based on Ruby 2.4.2, using Rails 5.  The project allows users to create, share, and organize their bookmarks in a central location.  Users may mark Favimarks of other users as a _favorite_ and add it to their own list of Favimarks.

# Some of the Basics
This project uses [Devise](https://github.com/plataformatec/devise) authentication, implementing <code>:confirmable</code>, <code>:lockable</code>, as well as other additional functions.  [Mailgun](https://github.com/mailgun/mailgun-ruby) is used for the mailer functionality.  Users are also able to email the system in order to add a bookmark to their account.  Bookmarks added by a user are added to the users list of favorites automatically, and it is added to the database of bookmarks.  [Pundit](https://github.com/elabs/pundit) is used in order to authorize users against various actions, such as adding and deleting Favimarks.

# Unique Challenge
1. In an effort to keep the flow coherent, it was decided to not use a <code>new.html.erb</code> file for the create action.  Instead, a bootstrap modal is used by way of AJAX.  If a user adds a new bookmark from within the App, a modal is displayed where the user can enter the URL and select a Topic.  This is then sent via an AJAX request and the bookmark is added to the user's account if it is valid.

2. In an effort to try to control the validity of URLs saved in the system, each bookmark is validated prior to adding it to the system.  The URL is tested and checked for an HTML Success return code using [HTTParty](https://github.com/jnunemaker/httparty) to call the URL via <code>GET</code>, and check for <code>response.success?</code>

[Limited Working Sample of Project](https://mywebmarks.herokuapp.com)

**NOTE:**
1. UN/PW: test@favimarks.com | helloworld
2. To add new bookmark, include the prefix [http(s)://]
3. May take up to 20 seconds for heroku to load the app
