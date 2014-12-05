class OrdersController < ApplicationController

  def select_car
  	@cars_info = Order.cars_data
  	pp @cars_info
  end

  def select_item
  end

  def place_order
  end

end
