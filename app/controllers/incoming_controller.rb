class IncomingController < ApplicationController
  include HTTParty

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here.

    # Find the user by using params[:sender]
    user = User.find_by_email(params["sender"])

    # Find the topic by using params[:subject]
    topic = Topic.find_by_title(params["subject"])

    # Assign the url to a variable after retreiving it from params["body-plain"]
    url = params["body-plain"]

    # Check if user is nil, if so, create and save a new user
      # This was skipped as I didn't much like the idea of just ~anyone~ being
      # able to email the system and create an account, essentially bypassing Devise

    if user && url && request.success?
    # Check if the topic is nil, if so, create and save a new topic
      if !topic
        t = Topic.create(title: params["subject"], user: user)
        t.bookmarks.create(url: url)
        t.save
        puts "Created New Topic With Bookmark Successfully!"
      else
        topic.bookmarks.create(url: url)
        topic.save
        puts "Added Bookmark To Topic Successfully!"
      end
    else
      error = ""
      error += "User does not exist.\n" if !user
      error += "URL does not exist.\n" if !url
      error += "URL is INVALID.\n" if !url_valid

      puts error


    # Now that you're sure you have a valid user and topic, build and save a new bookmark
    # Assuming all went well.

    end
    head 200
  end
end
