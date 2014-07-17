Rails.application.routes.draw do
  namespace :admin do
    get 'welcome' => 'welcome#index'
  end

  root :to => 'admin/welcome#index'
end
