class Api::TagFeedController < ApplicationController
  
  respond_to :json

  def index
    respond_with (@tagfeds = TagFeed.all)
  end  

  def show
    respond_with TagFeed.find(params[:id])
  end

  def create
    tf = TagFeed.new(tf_params)
    if tf.save
        render json: tf, status: 201, location:[:api, tf]
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

