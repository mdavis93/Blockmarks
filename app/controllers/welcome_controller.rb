class WelcomeController < ApplicationController
  def index
    @first_menu_link_url = bookmarks_path
    @first_menu_link_name = 'My Bookmarks'
    @topics = Topic.includes(bookmarks: [:likes]).all
  end

  def about; end
end
