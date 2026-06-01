Rails.application.routes.draw do
  # actual view: devise_for(:users, controllers: { sessions: "users/sessions", registrations: "users/registrations" })
  devise_for :users,
    controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             }
  # post("/graphql", to: "graphql#execute") 2 arguement passed, route and then controller action
  post "/graphql", to: "graphql#execute" # "#" split the string ["graphql", "execute"], now add Controller in front of graphql, and call .execute method
  get("up" => "rails/health#show", as: :rails_health_check)


  mount MissionControl::Jobs::Engine, at: "/mission_control/jobs"
end
