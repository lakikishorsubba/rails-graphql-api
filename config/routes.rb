Rails.application.routes.draw do
  root "posts#index"
  resources :posts

  devise_for :users,
    controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
  post "/graphql", to: "graphql#execute"
  get "up" => "rails/health#show", as: :rails_health_check
end
