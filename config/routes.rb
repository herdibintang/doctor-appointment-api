Rails.application.routes.draw do
  post 'user/login', to: 'user#login'
  get 'user/logout', to: 'user#logout'
  
  resources :doctor
  resources :hospital
  resources :schedule
  resources :user
  resources :appointment

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
