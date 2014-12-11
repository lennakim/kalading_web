Rails.application.routes.draw do
  mount WeixinRailsMiddleware::Engine, at: "/"

  resources :orders do
    get 'select_car',     on: :collection
    get 'select_item',    on: :collection

    post 'refresh_price', on: :collection
    post 'place_order',   on: :collection
    post 'submit_order',  on: :collection
  end

  root to: 'home#index'
end
