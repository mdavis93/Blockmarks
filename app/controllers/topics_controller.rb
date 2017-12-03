class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic created successfully!"
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error creating the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic updated successfully!"
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error updating the Topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" Topic successfully destroyed!"
      redirect_to topics_path
    else
      flash.now[:alert] = "There was an error processing your request. Please try again."
      render :show
    end
  end




  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
