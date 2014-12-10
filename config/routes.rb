Rails.application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :orders do
    get 'select_car', on: :collection
    get 'select_item', on: :collection
    post 'refresh_price', on: :collection
    post 'place_order', on: :collection
  end

  root to: 'home#index'

  resources :sessions

end
