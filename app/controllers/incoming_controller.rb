class IncomingController < ApplicationController
  include HTTParty

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.find_by_email(params["sender"])
    topic = Topic.find_by_title(params["subject"])

    url = params["body-plain"]

    if user && url
      if !topic
        topic = Topic.create!(title: params["subject"], user: user)
        b = Bookmark.new(url: url, topic: topic, user: user)
        b.save if b.valid?
        puts "Created New Topic With Bookmark Successfully!"
      else
        Bookmarks.new(url: url,topic: topic, user: user)
        b.save if b.valid?
        puts "Added Bookmark To Topic Successfully!"
      end
    end
    head 200
  end
end
