Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
    controllers: {
      omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "registrations"
    }

  resources :users, only: [:show, :index, :edit, :update, :destroy]
  resources :messages do
    resources :comments
  end
  root 'messages#index'
end
