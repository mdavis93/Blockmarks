class WelcomeController < ApplicationController
  def index
    @first_menu_link_url = current_user ? bookmarks_path : new_user_session_path
    @first_menu_link_name = 'My Bookmarks'
    @topics = Topic.includes(bookmarks: [:likes]).all
  end

  def about; end
end
