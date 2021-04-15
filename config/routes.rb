Rails.application.routes.draw do
  root 'static_pages#join_anizoku'
  namespace :static_pages do
    get :home
  end
  
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  get '/display_mode', to: 'static_pages#display_mode'
  get '/tags/tag_list', to: 'tags#index'
  get'/search', to: 'searchs#item_search'
  
  namespace :admin do
    get :menu
    resources :posts, except: :destroy
    resources :images
  end
  
  namespace :api do
    namespace :v1 do
      get 'search', to: 'search#index'
    end
  end
  
  resources :users, only: [:new, :create]
  get 'cast_works/', to: 'cast_works#index'
end