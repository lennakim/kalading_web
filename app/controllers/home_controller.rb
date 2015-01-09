class HomeController < ApplicationController
  def index
    @cars_info = Order.cars_data
  end
end
