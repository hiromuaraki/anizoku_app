Rails.application.routes.draw do
  root 'static_pages#join_anizoku'
  namespace :static_pages do
    get :home
    get :display_mode
  end
  
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  get '/tags/tag_list', to: "tags#index"
  
  namespace :admin do
    get :menu
    resources :posts, except: :destroy
    resources :images
  end
  
  resources :users, only: [:new, :create]
  resources :works
end