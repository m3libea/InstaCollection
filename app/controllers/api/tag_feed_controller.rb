class Api::TagFeedController < ApplicationController
  
  respond_to :json

  def index
    @tag_feeds = TagFeed.all

    respond_with @tag_feeds
  end  

  def show
      @tag_feed = TagFeed.find(params[:id])

      respond_to do |format|
      format.json {render :json => @tag_feed.to_json(:include=>[:media])}
    end
  end

  def create
    Rails.logger.info tf
    tf = TagFeed.new(params.require(:tag_feed).permit(:hashtag, :start_date, :end_date), initial_tag_id: nil, latest_tag_id: nil, is_complete: false)
    
    if tf.save
        render json: tf, status: 201, location:[:api, tf]
        #Get Media related to the tag
        TagFeedHelper::create_tag(tf)
    else
        render json: { errors: tf.errors}, status: 422
    end
  end  

  def update
    tf = TagFeed.find(params[:id])

    if tf.update(tf_params)
        render json: tf, status: 201, location:[:api, tf]
    else
        render json: { errors: tf.errors}, status: 422
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

