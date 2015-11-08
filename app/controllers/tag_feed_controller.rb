class TagFeedController < ApplicationController

  def new
    @tag_feed = TagFeed.new
  end

  def index
    @tag_feeds = TagFeed.all

    respond_to do |format|
      format.html
      format.json {render :json => @tag_feeds.to_json}
    end
  end  

  def show
    @tag_feed = TagFeed.find(params[:id])

    respond_to do |format|
      format.html
      format.json {render :json => @tag_feed.to_json(:include=>[:media])}
    end
  end

  def create
    @tag_feed = TagFeed.new(params.require(:tag_feed).permit(:hashtag, :start_date, :end_date), initial_tag_id: nil, latest_tag_id: nil, is_complete: false)
    
    respond_to do |format|
      if @tag_feed.save
        TagFeedHelper::create_tag(@tag_feed)
        format.html { redirect_to @tag_feed, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @tag_feed }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end  

  def edit
    @tag_feed = TagFeed.find(params[:id])
  end

  def update
    @tag_feed = TagFeed.find(params[:id])

    if @tag_feed.update(tf_params)
        render json: @tag_feed, status: 201, location:[:api, @tag_feed]
    else
        render json: { errors: @tag_feed.errors}, status: 422
    end    
  end  

  def destroy
    tf = TagFeed.find(params[:id])
    tf.destroy
    head 204
  end  


  private
    def tf_params
        params.require(:tag_feed).permit(:hashtag, :start_date, :end_date, :initial_tag_id, :latest_tag_id, :is_complete)
    end 
end

