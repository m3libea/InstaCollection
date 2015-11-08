Rails.application.routes.draw do

  #namespace :api, defaults: {format: :json} do
  #      resources :tag_feed, :only=>[:show, :index, :create, :update, :destroy]
  #end

  # You can have the root of your site routed with "root"
  root 'tag_feed#index'
  #get 'new_tag'=> 'tag#new'
  #post 'new_tag' => ''
  resources :tag_feed

end
