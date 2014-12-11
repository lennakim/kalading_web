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

  root to: 'home#index'

  resources :sessions do
    post 'callback', on: :collection
    post 'by_phone', on: :collection
  end

end
