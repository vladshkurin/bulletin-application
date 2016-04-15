Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
             controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  resources :users, only: [:show, :index]
  resources :messages do
    resources :comments
  end
  root 'messages#index'
end
  