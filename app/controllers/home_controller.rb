class HomeController < ApplicationController
  def index
    @cars_info = Order.cars_data current_city_id
  end
end
