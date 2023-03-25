Rails.application.routes.draw do
  root                      "static_pages#home"
  get "/help",          to: "static_pages#help"
  get "/about",         to: "static_pages#about"
  get "/signup",        to: "users#new"
  get "/login",         to: "sessions#new"
  post "/login",        to: "sessions#create"
  delete "/logout",     to: "sessions#destroy"

  resources :users do 
    resources :tier_lists do 
      resources :tiers do
        resources :tier_movies, only: [:create, :destroy] do
          member do 
            put :sort
          end 
        end
        member do 
          put :sort
        end 
      end
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
