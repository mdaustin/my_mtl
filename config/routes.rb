Rails.application.routes.draw do
  root                       "static_pages#home"
  get "/help",           to: "static_pages#help"
  get "/about",          to: "static_pages#about"
  get "/signup",         to: "users#new"
  get "/login",          to: "sessions#new"
  post "/login",         to: "sessions#create"
  delete "/logout",      to: "sessions#destroy"
  get "/users/:user_id/tier_lists/:tier_list_id/movies/search",
                         to: "movies#search", as: "search_movies"


  resources :users do 
    resources :tier_lists do 
      resources :tiers do
        resources :tier_movies, only: [:create, :destroy, :update] do
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

  resources :movies
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
