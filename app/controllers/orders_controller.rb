class OrdersController < ApplicationController

  def select_car
    @cars_info = Order.cars_data
    pp @cars_info
  end

  def refresh_price
    car_id = params["order"]["car_id"]
    parts = params["order"]["parts"].try :values
    payload = {
      "parts" => parts
    }
    Rails.logger.info payload
    result = Order.refresh_price car_id, payload
    render json: { result: result }
  end

  def select_item
    @result = Order.items_for params[:car_id]
  end

  def place_order
    car_id = params["order"]["car_id"]
    parts = params["order"]["parts"]
    payload = {
      "parts" => parts
    }

    @result = Order.refresh_price car_id, payload
  end

  def submit_order

  end

  def show
  end

end
