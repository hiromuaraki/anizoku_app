Rails.application.routes.draw do
  root 'static_pages#join_anizoku'
  
  namespace :static_pages do
    get :home
    get :privacy
  end
  
  get '/admin', to: 'admin#index'
  namespace :admin do
    resources :posts, except: :destroy
  end
  resources :users, only: [:new, :create]
end