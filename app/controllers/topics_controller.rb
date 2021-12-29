class TopicsController < ApplicationController
  before_action :set_sidebar_topics
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
	layout 'blog'
  access all: [:index], user: {except: [:destroy, :new, :create, :edit, :update, :show]}, site_admin: :all

  def index
  	@topics = Topic.all.page(params[:page]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  	@topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_sidebar_topics
    @side_bar_topics = Topic.with_blogs
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
