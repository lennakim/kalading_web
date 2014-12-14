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
    post 'callback', on: :collection
    post 'by_phone', on: :collection
  end

  namespace :admin do
    root to: 'home#index'
    resources :home
    resources :activities
  end

  get 'activities/9.9' => "activity/home#activity_99"

end
