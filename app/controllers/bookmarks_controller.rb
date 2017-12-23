# BookmarksController
class BookmarksController < ApplicationController
  before_action :set_bookmark, only: %i[show edit update destroy]

  def index
    @bookmark = Bookmark.where(user_id: current_user.id)
                        .sort_by { |e| e.url.downcase }
    @like = Like.where(user_id: current_user.id).pluck(:bookmark_id)
  end

  def show
    @first_menu_link_name = 'Share Bookmark'
    @first_menu_url = @bookmark
  end

  def new
    @bookmark = Bookmark.new
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @bookmark = current_user.bookmarks.create(bookmark_params)
    @bookmark.user = current_user
    respond_to do |format|
      if @bookmark.save
        format.json { head :no_content }
        format.js
        current_user.likes.create!(bookmark: @bookmark) unless current_user.liked(@bookmark)
      else
        format.json { render json: @bookmark.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def edit
    unless policy(@bookmark).edit?
      flash[:alert] = 'You are not authorized to do that!'
      if !current_user
        redirect_to new_user_session_path
      else
        redirect_to topics_path
      end
    end

    @bookmark = Bookmark.find(params[:id])
  end

  def update
    respond_to do |format|
      if @bookmark.update_attributes(bookmark_params)
        format.json { head :no_content }
        format.js
      else
        format.json do
          render json: @bookmark.errors.full_messages,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:notice] = 'Bookmark was deleted successfully!'
      redirect_to @bookmark.topic
    else
      flash.now[:alert] = 'There was an error deleting the bookmark.'
      render :show
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id)
  end
end
