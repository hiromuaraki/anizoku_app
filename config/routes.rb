Rails.application.routes.draw do
  root 'static_pages#join_anizoku'
  namespace :static_pages do
    get :home
    get :privacy
  end
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  
  get '/admin', to: 'admin#index'
  namespace :admin do
    resources :posts, except: :destroy
  end
  resources :users, only: [:new, :create]
end