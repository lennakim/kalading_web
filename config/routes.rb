Rails.application.routes.draw do

  resources :orders do
    get 'select_car', on: :collection
    get 'select_item', on: :collection
    post 'place_order', on: :collection
  end

  root to: 'home#index'
end
