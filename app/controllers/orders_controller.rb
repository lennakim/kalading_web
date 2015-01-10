class OrdersController < ApplicationController

  def select_car
    type = params[:type]
    @cars_info = Order.cars_data type
    @result = Order.items_for params[:car_id]
  end

  def refresh_price
    car_id = params["order"]["car_id"]
    parts = params["order"]["parts"].try :values
    payload = {
      "parts" => parts
    }
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

  def submit

    payload = {
      parts: params[:parts].values,
      info: {
        "address"        => params[:address],
        "name"           => params[:name],
        "phone_num"      => params[:phone_num],
        "car_location"   => params[:car_location],
        "car_num"        => params[:car_num],
        "serve_datetime" => "#{params[:serve_date]} #{params[:serve_period]}",
        "pay_type"       => params[:pay_type],
        "reciept_type"   => 1,
        "reciept_title"  => "卡拉丁汽车技术",
        "client_comment" => params[:client_comment],
        "city_id"        => params[:city_id],
        "car_id"         => params[:car_id],
        "registration_date" => params[:registration_date],
        "engine_num"     => params[:engine_num],
        "vin"            => params[:vin]
      }
    }

    result = Order.submit params[:car_id], payload
    if result["result"] == "succeeded"

      # add this car to user
      current_user.add_auto payload[:info]

      # send notification to user's wechat

      render "success"
    else
      render "fail"
    end
  end

  def show
  end

  def order_status
  end


end
