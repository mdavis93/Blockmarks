class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  def show
    @first_menu_link_name = "Share Bookmark"
    @first_menu_url = @bookmark
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user

    respond_to do |format|
      if @bookmark.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @bookmark.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def edit
    if !policy(@bookmark).edit?
      flash[:alert] = "You are not authroized to do that!"
      if !current_user
        redirect_to new_user_session_path
      else
        redirect_to topics_path
      end
    end
  end

  def update
    respond_to do |format|
      if @bookmark.update_attributes(bookmark_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @bookmark.errors.full_messages,
                      status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted successfully!"
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end




  private
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    # User the current bookmark's topic for now, ask Chris how to convert
    params.require(:bookmark).permit(:url, :topic_id)
  end
end
