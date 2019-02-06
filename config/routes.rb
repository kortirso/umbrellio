Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: %i[create] do
        get :top, on: :collection
        get :ips_with_users, on: :collection
      end
      resources :rates, only: %i[create]
    end
  end
end
