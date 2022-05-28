Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :contacts
  resources :users, except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'signup', to: 'users#new'
end
