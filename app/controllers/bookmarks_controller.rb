class BookmarksController < ApplicationController
  def show
    @bookmark = Bookmark.find(params[:id])
    @first_menu_link_name = "Share Bookmark"
    @first_menu_url = @bookmark
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
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
