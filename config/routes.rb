Rails.application.routes.draw do

  mount WeixinRailsMiddleware::Engine, at: "/"
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts

  resources :cities do
    post 'set'
  end

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
      get 'new'
    end
  end

  root to: 'home#index'

  resources :sessions do
    get 'callback',  on: :collection
  end

  namespace :admin do
    root to: 'main#index'
    resources :main
    resources :activities
    resources :channels
    resources :users
    resources :posts
  end

  namespace :activity do
    resources :main
  end

  resources :phones do
    post :send_verification_code, on: :collection
  end

  get 'activities/:name' => 'activity/main#show', as: 'activity'
end
