class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

    # You put the message-splitting and business
    # magic here.

    # Find the user by using params[:sender]
    user = User.find_by_email(params[:sender])

    # Find the topic by using params[:subject]
    topic = Topic.find_by_title(params[:subject])

    # Assign the url to a variable after retreiving it from params["body-plain"]
    url = params["body-plain"]

    # Check if the URL is valid by making a GET request, and checking for HTTPSuccess
    reqest = Net::HTTP.get_response(URI(url))
    url_valid = request.kind_of? Net::HTTPSuccess

    # Check if user is nil, if so, create and save a new user
      # This was skipped as I didn't much like the idea of just ~anyone~ being
      # able to email the system and create an account, essentially bypassing Devise

    if user && url && url_valid
    # Check if the topic is nil, if so, create and save a new topic
      if topic
        t = Topic.create(topic: topic, user: user)
        t.bookmarks.create(url: url)
        t.save
        puts "success!"
      else
        puts "Error: No Topic"
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
