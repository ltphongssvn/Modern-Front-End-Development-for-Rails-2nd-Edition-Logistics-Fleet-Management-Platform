# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  namespace :api do
    namespace :v1 do
      resources :vehicles
      resources :routes
      resources :gps_trackings, only: [:index, :create] do
        collection do
          get 'latest/:vehicle_id', to: 'gps_trackings#latest'
        end
      end
      resources :deliveries
      resources :telemetries, only: [:index, :create]
    end
  end
  
  mount ActionCable.server => '/cable'
  
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  root "dashboard#index"
end
