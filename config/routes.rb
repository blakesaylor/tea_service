Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do
      resources :customer, only: [] do
        resources :subscriptions, only: [ :index, :create, :update ], controller: 'customers/subscriptions'
      end
    end
  end
end
