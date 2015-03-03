Rails.application.routes.draw do

  mount WeixinRailsMiddleware::Engine, at: "/"
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts do
    collection do
      get 'about_us'
      get 'knowledge'
      get '/:tag_id/:slug', action: 'show', as: 'slug'
      get '/:tag_id', action: 'posts_list', as: 'list'
    end
  end

  resources :wx, controller: :weixin  do
    get 'transform', on: :collection
  end

  resources :cities do
    post 'set'
  end

  resources :orders do
    member do
      post 'comment'
    end

    collection do
      get 'select_car'
      get 'select_item'
      get 'success'
      get 'order_status'

      get 'select_car_item'
      get 'auto_brands'
      get 'auto_series'
      get 'auto_model_numbers'

      post 'refresh_price'
      post 'place_order'
      post 'submit'
      post 'validate_preferential_code'
      post 'no_preferential'
      get  'no_car_type'
      post 'submit_no_car_order'
      get  'pay_show'
      post 'pay'
      get 'notify'
    end
  end

  resources :users do
    collection do
      get 'orders'
      get 'maintain_histories_list'
      get 'maintain_history'
      get 'cars'
      get 'balance'
      get 'settings'
    end
  end

  resources :service_addresses do
    post 'set_default'
  end

  resources :autos

  root to: 'home#index'

  resources :sessions do
    get 'callback',  on: :collection
    post 'notify', on: :collection
    delete 'destroy', on: :collection
  end

  namespace :admin do
    root to: 'main#index'
    resources :main
    resources :activities
    resources :channels
    resources :users
    resources :posts
    resources :cities
    resources :products
    resources :public_accounts do
      collection do
        get 'apply_menu' => 'public_accounts#apply_menu'
        get 'diy_menu' => 'public_accounts#diy_menu'
        get 'edit_menu' => 'public_accounts#edit_menu'
        post ':id/update_menu' => 'public_accounts#update_menu', as: 'update_menu'
      end
    end
    resources :qrcodes
    resources :weixin
  end

  namespace :activity do
    resources :main do
      collection do
        get 'select_city'
      end
    end
  end

  resources :phones do
    post :send_verification_code, on: :collection
  end

  get 'activities/:name' => 'activity/main#show', as: 'activity'
end
