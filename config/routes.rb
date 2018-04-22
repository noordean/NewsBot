Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "bots#index"

  post "message" => "bots#message"
  get "greet" => "bots#greet"
end
