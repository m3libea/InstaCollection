Rails.application.routes.draw do

  resources :tag_feed

  root 'tag_feed#index'
end
