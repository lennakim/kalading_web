Rails.application.routes.draw do
  resources :orders

  root to: 'home#index'
end
