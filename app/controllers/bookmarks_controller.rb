class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
    @first_menu_link_name = "Share Bookmark"
    @first_menu_url = @bookmark
  end

  def edit
    if policy(Bookmark.find(params[:id])).edit?
      @bookmark = Bookmark.find(params[:id])
    else
      flash[:alert] = "You are not authroized to do that!"
      if !current_user
        redirect_to new_user_session_path
      else
        redirect_to topics_path
      end
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark Updated Successfully!"
      redirect_to [@bookmark.topic, @bookmark]
    else
      flash.now[:alert] = "There was an error updating the bookmark, please try again!"
    end
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)

    if @bookmark.save
      flash[:notice] = "Bookmark was saved successfully!"
      redirect_to [@topic, @bookmark]
    else
      flash.now[:alert] = "There was an error saving the bookmark. Please try again."
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Bookmark was deleted successfully!"
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = "There was an error deleting the bookmark."
      render :show
    end
  end




  private
  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
