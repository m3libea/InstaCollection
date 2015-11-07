Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
        resources :tag_feed, :only=>[:show, :index]
  end

  # You can have the root of your site routed with "root"
  root 'application#hello'

end
