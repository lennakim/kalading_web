class OrdersController < ApplicationController

  def select_car
  	@cars_info = Order.cars_data
  end

  def select_item
  end

  def place_order
  end

end
