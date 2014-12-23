Rails.application.routes.draw do

  mount WeixinRailsMiddleware::Engine, at: "/"

  resources :orders do
    collection do
      get 'select_car'
      get 'select_item'

      post 'refresh_price'
      post 'place_order'
      post 'submit'
    end
  end

  resources :users do
    collection do
      get 'orders'
      get 'maintain_histories'
      get 'cars'
      get 'balance'
    end
  end

  root to: 'home#index'

  resources :sessions do
    get 'callback',  on: :collection
  end

  namespace :admin do
    root to: 'home#index'
    resources :home
    resources :activities
    resources :channels
  end

  namespace :activity do
    resources :home
  end

  resources :phones do
    post :send_verification_code, on: :collection
  end

  get 'activities/:name' => 'activity/home#show', as: 'activity'
end
