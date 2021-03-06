Rails.application.routes.draw do
  namespace :admin do
    resources :jobs, :only => [:index, :destroy, :show] do
      member do
        post :retry
      end
    end
    resources :outbound_requests, only: [:index, :show]
  end
end
