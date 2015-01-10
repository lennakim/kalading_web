class OrdersController < ApplicationController

  def select_car
    type = params[:type]
    @cars_info = Order.cars_data type
    @result = Order.items_for params[:car_id]
  end

  def comment
    data = Order.comment params[:id], {
      evaluation: params[:content],
      evaluation_tags: params[:tags],
      evaluation_score: params[:score]
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
    @result = Order.items_for params[:car_id]
  end

  def place_order
    car_id = params["order"]["car_id"]
    parts = params["order"]["parts"]
    payload = {
      "parts" => parts
    }
    @cities = Order.cities
    @result = Order.refresh_price car_id, payload
  end

  def submit

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:verification_code])

    if !signed_in? && !(vcode && !vcode.expired?)
      return render "fail"
    end

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

      # find_or_create user
      user = User.find_or_create_by(phone_number: vcode.phone_num)
      unless signed_in?
        sign_in user
      end

      # add this car to user , TODO this api is not done
      # user.add_auto payload[:info]

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
