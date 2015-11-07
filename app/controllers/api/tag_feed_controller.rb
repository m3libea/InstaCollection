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

  private
    def tf_params
        params.permit(:hashtag, :startDate, :endDate, :initialTagID, :latestTagID, :isComplete)
    end  
end

