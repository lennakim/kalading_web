class OrdersController < ApplicationController

  def pay_show
    @param = {
      body: '测试商品',
      out_trade_no: 'test666',
      total_fee: 1,
      spbill_create_ip: '121.42.155.108',
      notify_url: 'http://staging.kalading.com/sessions/notify',
      trade_type: 'NATIVE'
    }
  end

  def pay
    param = {
      body: '测试商品',
      out_trade_no: 'test666',
      total_fee: 1,
      spbill_create_ip: '121.42.155.108',
      notify_url: 'http://staging.kalading.com/sessions/notify',
      trade_type: 'NATIVE'
    }
    r = WxPay::Service.invoke_unifiedorder param

    if r.success?
      Rails.logger.info("-"*50)
      Rails.logger.info(r)
      redirect_to r["code_url"]
    else
      Rails.logger.info("@"*50)
      redirect_to pay_show_orders_path
    end
  end

  def notify
=begin
    result = Hash.from_xml(request.body.read)["xml"]
     if WxPay::Sign.verify?(result)
       render :xml => { return_code: "SUCCESS" }.to_xml(root: 'xml', dasherize: false)
     else
       render :xml => { return_code: "SUCCESS", return_msg: "签名失败" }.to_xml(root: 'xml', dasherize: false)
     end
=end
    Rails.logger.info("+"*100)

    render plain: "OK"
  end

  def validate_preferential_code
    code = params[:code]
    car_id = params["car_id"]
    @parts = params["parts"].try :values

    payload = {
      parts: @parts,
      discount: code
    }
    @result = Order.refresh_price car_id, current_city_id, payload
  end

  def no_preferential
    car_id = params["car_id"]
    @parts = params["parts"].values
    payload = {
      parts: @parts
    }
    @result = Order.refresh_price car_id, current_city_id, payload
  end

  def auto_brands
  end

  def auto_series
  end

  def auto_model_numbers
  end

  def select_car
    type = params[:type]

    if last_select_car.present?
      @last_select_car = Auto.api_find last_select_car
    end

    @cars_info = Order.cars_data current_city_id, type
    # @result = Order.items_for params[:car_id], current_city_id, type
  end

  def select_car_item

    unless browser.mobile?
      return redirect_to select_car_orders_path(act: params[:act], type: params[:type])
    end

    if params[:car_id] || last_select_car.present?

      car_id = params[:car_id] || last_select_car

      if !params[:auto_id].present?
        save_last_select_car(car_id)
      end

      if last_select_car.present?
        cache_key = "#{last_select_car}/car_info"
        @last_select_car = Rails.cache.fetch(cache_key)

        if !@last_select_car
          @last_select_car = Auto.api_find last_select_car
          Rails.cache.write(cache_key, @last_select_car)
        end
      end

      type = params[:type]
      # @cars_info = Order.cars_data current_city_id, type

      cache_key = "#{car_id}/#{current_city_id}/#{type}/result"
      @result = Rails.cache.fetch(cache_key)
      if !@result
        @result = Order.items_for car_id, current_city_id, type
        Rails.cache.write(cache_key, @result)
      end

    else
      return redirect_to auto_brands_orders_path(act: params[:act], type: params[:type])
    end
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

    activity = Activity.find_by id: params[:act]

    payload = {
      parts: parts
    }

    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    result = Order.refresh_price car_id, current_city_id, payload
    render json: { result: result }
  end

  def select_item
    type = params[:type]

    if !params[:auto_id].present?
      save_last_select_car params[:car_id]
    end

    @result = Order.items_for params[:car_id], current_city_id, type
  end

  def place_order
    car_id = params["order"]["car_id"]
    @parts = params["order"]["parts"]
    @city_capacity = Order.city_capacity current_city_id

    @auto = Auto.find_by id: params[:auto_id]

    activity = Activity.find_by id: params[:act]

    payload = {
      parts: @parts
    }

    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    @cities = Order.cities
    @result = Order.refresh_price car_id, current_city_id, payload
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

    if !params[:address]
      return render js: "$('#add_address_modal').modal();"
    end

    city_name = params[:address][/.+?市/][0..-2]
    city = City.find_by(name: city_name)

    if !signed_in? && !(vcode && !vcode.expired?)
      return render js: "alert('请填写正确的验证码')"
    end

    parts = params[:parts] ? params[:parts].values : []

    if !params[:serve_date].present?
      return render js: "alert('请填写正确的服务日期')"
    end

    if !params[:registration_date].present?
      return render js: "alert('请填写正确的车辆注册日期')"
    end

    payload = {
      parts: parts,
      info: {
        "address"           => params[:address],
        "name"              => params[:name],
        "phone_num"         => params[:phone_num],
        "car_location"      => params[:car_location],
        "car_num"           => params[:car_num],
        "serve_datetime"    => "#{params[:serve_date]} #{params[:serve_period]}",
        "reciept_type"      => params[:reciept_type],
        "reciept_title"     => params[:reciept_title],
        "client_comment"    => params[:client_comment],
        "city_id"           => city.system_id, #params[:city_id]
        "car_id"            => params[:car_id],
        "registration_date" => params[:registration_date],
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

      redirect_via_turbolinks_to action: :success
    else
      render js: "alert('请填写正确的订单信息')"
    end
  end

  def show
  end

  def success
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
