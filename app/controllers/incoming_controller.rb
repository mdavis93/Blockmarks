class IncomingController < ApplicationController
  include HTTParty

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "\nINCOMING PARAMS:\n#{params}"
    user = User.find_by_email(params['sender'])
    return head 200 unless user

    url = params['body-plain'].strip
    topic = Topic.find_by(title: 'From Email')
    topic = Topic.create(title: 'From Email', user: user) if topic.nil?

    b = create_bookmark(url, topic, user)

    return_code(b)
  end

  def create_bookmark(url, topic, user)
    b = Bookmark.new(url: url, topic: topic, user: user)

    b unless b.invalid?
  end

  def return_code(bookmark)
    head 400 if bookmark.nil?
    if bookmark.save
      head 201
    else
      head 422
    end
  end
end


