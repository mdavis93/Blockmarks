class LikesController < ApplicationController
  def index
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    flash[:alert] = 'Unable to add to favorites, please try again.' unless like.save
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = Like.find(params[:id])

    unless like.destroy

    end
  end
end
