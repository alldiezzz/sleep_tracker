Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "dashboards#index"

  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :users, only: :create, param: :user_id do
          collection do
            post :follow
            delete :unfollow
          end

          member do
            get :sleep_sessions
            get :followed_sleep_sessions
          end
        end
        resources :sleep_records, only: :create do
          collection do
            post :add_event
          end
        end
      end
    end
  end
end
