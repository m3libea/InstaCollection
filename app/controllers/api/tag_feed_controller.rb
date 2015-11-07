class Api::TagFeedController < ApplicationController
  
  respond_to :json

  def index
    respond_with (@tagfeds = TagFeed.all)
  end  

  def show
    respond_with TagFeed.find(params[:id])
  end
 
end

