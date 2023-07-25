Rails.application.routes.draw do
  # root "tickets#index"

  # API routes
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :tickets, only: %i[create]
    end
  end
end
