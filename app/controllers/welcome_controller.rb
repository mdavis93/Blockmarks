class WelcomeController < ApplicationController
  def index
    # TODO: Change syntax to match production DB method for RAND()
    @topics = Topic.includes(bookmarks: [:likes]).all

  end

  def about; end
end
