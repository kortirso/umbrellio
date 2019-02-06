Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create]
      resources :rates, only: %i[create]
    end
  end
end
