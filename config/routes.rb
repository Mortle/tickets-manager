Rails.application.routes.draw do
  resources :tickets, only: %i[index show]

  # API routes
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :tickets, only: %i[create]
    end
  end

  root "tickets#index"
end
