class OrdersController < ApplicationController

  def validate_preferential_code
    code = params[:code]
    car_id = params["car_id"]
    @parts = params["parts"].values

    payload = {
      parts: @parts,
      discount: code
    }
    @result = Order.refresh_price car_id, payload
  end

  def no_preferential
    car_id = params["car_id"]
    @parts = params["parts"].values
    payload = {
      parts: @parts
    }
    @result = Order.refresh_price car_id, payload
  end

  def auto_brands
    @brands = Order.auto_brands
  end

  def auto_series
    @series = Order.auto_series params[:brand_id]
  end

  def auto_model_numbers
    @auto_model_numbers = Order.auto_model_numbers params[:series_id]
  end

  def select_car
    type = params[:type]

    if last_select_car
      @last_select_car = Auto.api_find last_select_car
    end

    @cars_info = Order.cars_data type
    @result = Order.items_for params[:car_id]
  end

  def select_car_item

    unless params[:auto_id]
      save_last_select_car params[:car_id]
    end
    
    @last_select_car = Auto.api_find(last_select_car) if last_select_car.present?
    
    type = params[:type]
    @cars_info = Order.cars_data type
    @result = Order.items_for params[:car_id]
  end

  def comment
    data = Order.comment params[:id], {
      evaluation_tags: params[:tags],
      evaluation_score: params[:score],
      evaluation_time: Time.now.to_s
    }

    @id = params[:id]
    @order = Order.find params[:id]

    if data && data["result"] == "ok"
      render "comment"
    else
      render js: "alert('评价失败')"
    end
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
    save_last_select_car params[:car_id]
    @result = Order.items_for params[:car_id]
  end

  def place_order
    car_id = params["order"]["car_id"]
    @parts = params["order"]["parts"]
    @city_capacity = Order.city_capacity current_city_id
    payload = {
      "parts" => @parts
    }
    @cities = Order.cities
    @result = Order.refresh_price car_id, payload
  end

  def no_car_type
    @city_capacity = Order.city_capacity current_city_id
    @cities = Order.cities
  end

  def submit_no_car_order

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:verification_code])

    if !signed_in? && !(vcode && !vcode.expired?)
      return render "fail"
    end

    payload = {
      "info" => {
        "address"           => params[:address],
        "name"              => params[:name],
        "phone_num"         => params[:phone_num],
        "car_location"      => params[:car_location],
        "car_num"           => params[:car_num],
        "serve_datetime"    => "#{params[:serve_date]} #{params[:serve_period]}",
        "pay_type"          => params[:pay_type],
        "client_comment"    => "#{params[:brand]} #{params[:year]} #{params[:car_pl]}",
        "city_id"           => params[:city_id],
        "registration_date" => params[:registration_date]
      }
    }

    result = Order.submit_no_car_order payload
    if result["result"] == "succeeded"

      unless signed_in?
        user = User.find_or_create_by(phone_number: vcode.phone_num)
        sign_in user
      end

      render "success"
    else
      render "fail"
    end
  end

  def submit

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:verification_code])

    if !signed_in? && !(vcode && !vcode.expired?)
      return render "fail"
    end

    payload = {
      parts: params[:parts].values,
      info: {
        "address"           => params[:address],
        "name"              => params[:name],
        "phone_num"         => params[:phone_num],
        "car_location"      => params[:car_location],
        "car_num"           => params[:car_num],
        "serve_datetime"    => "#{params[:serve_date]} #{params[:serve_period]}",
        "pay_type"          => params[:pay_type],
        "reciept_type"      => params[:reciept_type],
        "reciept_title"     => params[:reciept_title],
        "client_comment"    => params[:client_comment],
        "city_id"           => params[:city_id],
        "car_id"            => params[:car_id],
        "registration_date" => params[:registration_date],
        "engine_num"        => params[:engine_num],
        "vin"               => params[:vin],
        "discount"          => params[:discount]
      }
    }

    result = Order.submit params[:car_id], payload
    if result["result"] == "succeeded"

      # find_or_create user
      user = current_user

      user = current_user

      unless signed_in?
        user = User.find_or_create_by(phone_number: vcode.phone_num)
        sign_in user
      end

      # add this car to user , TODO this api is not done
      user.add_auto payload[:info]

      # send notification to user's wechat TODO

      render "success"
    else
      render "fail"
    end
  end

  def show
  end

  def order_status
  end

  def destroy
    data = Order.cancel params[:id]
    @id = params[:id]
    @order = Order.find params[:id]
    if data["result"] == "ok"
      render "destroy"
    else
      render js: "alert('取消失败, 请刷新重试')"
    end
  end
end
