Rails.application.routes.draw do
  root 'static_pages#join_anizoku'
  namespace :static_pages do
    get :home
  end
  
  get '/auth/:provider/callback', to: 'sessions#create'
  delete 'logout', to:'sessions#destroy'
  get '/display_mode', to: 'static_pages#display_mode'
  get '/tags/tag_list', to: 'tags#index'
  get'/search', to: 'searchs#item_search'
  get '/cast_works/:cast_name', to: 'cast_works#index'
  get '/works/detail/:work_id', to: 'works#index'
  post '/works/detail/:work_id', to: 'works#create'
  get 'organizations/:organization_id', to: 'organizations#index'
  get '/tags/work_list/:tag_id', to: 'tags#work_tag_list'
  patch '/watches/update', to: 'watches#update'
  patch '/mylists/update/:work_id', to: 'mylists#update'
  patch '/mylists/update2/:work_id', to: 'mylists#update2'
  get '/users/my_page', to: 'users#my_page'
  get '/users/reviews', to: 'reviews#reviews'
  get 'users/mylists/index', to: 'mylists#index'
  get 'users/this_term_list', to: 'users#get_this_term_list'
  get 'users/first_term_list', to: 'users#get_first_term_list'
  get 'users/next_term_list', to: 'users#get_next_term_list'
  get '/season/season_list/:year', to: 'season#season_list'
  
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

  resource :users, only: :create
  resources :reviews, except: :destroy
end