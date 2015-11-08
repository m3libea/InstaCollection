Rails.application.routes.draw do

  resources :tag_feed

  root 'tag_feed#index'

  patch 'tag_feed/:id' => 'tag_feed#update'
end
