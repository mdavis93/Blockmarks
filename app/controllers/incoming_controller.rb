class IncomingController < ApplicationController
  include HTTParty

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "\nINCOMING PARAMS:\n#{params}"
    user = User.find_by_email(params["sender"])
    return head 200 unless user

    url = params["body-plain"]

    topic = create_topic(params["subject"], user)
    b = create_bookmark(url, topic, user)

    head 200
  end
end
