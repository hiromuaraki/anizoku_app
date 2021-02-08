Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admin#index'
  namespace :admin do
    resources :posts
  end

end
