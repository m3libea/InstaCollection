Rails.application.routes.draw do

  resources :tag_feed

  root 'tag_feed#index'

  post "/tag_feeds", to: "tag_feed#create"
end
