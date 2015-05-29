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

  def new
    render layout: "new"
  end

  def new_car_select
    unless browser.mobile? ;  end

    if car_id = cookies["car_id"] || last_select_car
      @last_select_car = Auto.api_find(car_id)
    end

    @city_capacity = Order.city_capacity current_city_id

    if signed_in?
      @autos = current_user.autos.recent
    end

    if @last_select_car
      if @autos
        @autos.unshift(@last_select_car)
      else
        @autos = [@last_select_car]
      end
    end

    render layout: "new"
  end

  def new_service_select
    @car_id = params[:car_id] || last_select_car
    @type = params[:type]

    if @car_id.present?
      save_last_select_car @car_id # cookie 保存选车id

      @result = Order.items_for2 @car_id, current_city_id, @type
    else

    end

    render layout: "new"

  end

  def new_info_submit

    @car_id = params["car_id"]
    @parts = JSON.parse cookies["parts"]
    @type = params["type"]

    if cookies[:version4] == "1"
      @city_capacity = Order.city_capacity current_city_id, 1
    else
      @city_capacity = Order.city_capacity current_city_id
    end

    if signed_in?
      @user_info = Order.user_orders(current_user.phone_number, @car_id).first
    end

    activity = Activity.find_by id: params[:act]


    payload = {
      parts: @parts
    }

    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    @cities = Order.cities
    @result = Order.refresh_price @car_id, current_city_id, payload, @type

    render layout: "new"
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
    if code.present?

      type = params["type"]
      car_id = params["car_id"] || "531f1fd2098e71b3f8003265"

      if cookies['parts']
        @parts = JSON.parse cookies['parts']
      else
        @parts = []
      end

      payload = {
        parts: @parts,
        discount: code,
        service_type: type
      }

      @result = Order.refresh_price car_id, current_city_id, payload, type
    else
      render js: "alert('优惠码不能为空')"
    end
  end

  def no_preferential
    car_id = params["car_id"]

    @parts = JSON.parse cookies['parts']

    type = params["type"]

    payload = {
      parts: @parts
    }
    @result = Order.refresh_price car_id, current_city_id, payload, type
  end

  def auto_brands
  end

  def auto_series
  end

  def auto_model_numbers
  end

  def select_car_by_initial
    @cars = Order.cars_data current_city_id
  end

  def select_car
    type = params[:type]

    if last_select_car.present?
      @last_select_car = Auto.api_find last_select_car
    end

    @cars_info = Order.cars_data current_city_id, type
    # @result = Order.items_for params[:car_id], current_city_id, type
  end

  def select_car_item # select car

    unless browser.mobile?
      return redirect_to select_car_orders_path(act: params[:act], type: params[:type])
    end

    if params[:car_id] || last_select_car.present?

      car_id = params[:car_id] || last_select_car

      if !params[:auto_id].present?
        save_last_select_car(car_id)
      end

      if last_select_car.present?
        @last_select_car = Auto.api_find last_select_car
      end

      type = params[:type]

      @result = Order.items_for2 car_id, current_city_id, type
    else
      return redirect_to select_car_by_initial_orders_path(act: params[:act], type: params[:type])
    end
  end

  def comment
    data = Order.comment params[:id], params[:desc], params[:score]

    # @order = Order.find(params[:id])['data']

    if data && data["code"] == 0
      render "comment"
    else
      render js: "alert('评价失败')"
    end
  end

  def refresh_price
    car_id = params["car_id"]
    type = params["type"]

    parts = JSON.parse cookies['parts']

    activity = Activity.find_by id: params[:act]

    payload = {
      parts: parts
    }

    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    result = Order.refresh_price car_id, current_city_id, payload, type
    render json: { result: result }
  end

  def select_item
    type = params[:type]

    if !params[:auto_id].present?
      save_last_select_car params[:car_id]
    end

    @result = Order.items_for params[:car_id], current_city_id, type
  end

  def place_order_page
    car_id = params[:car_id]
    @parts = JSON.parse cookies["parts"]

    if cookies[:version4] == "1"
      @city_capacity = Order.city_capacity current_city_id, 1
    else
      @city_capacity = Order.city_capacity current_city_id
    end

    activity = Activity.find_by id: params[:act]

    type = params["type"]

    if signed_in?
      @user_info = Order.user_orders(current_user.phone_number, car_id).first
    end

    payload = {
      parts: @parts
    }
    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    @cities = Order.cities
    @result = Order.refresh_price car_id, current_city_id, payload, type

    render "place_order"
  end

  def place_order
    car_id = params["order"]["car_id"]
    @parts = params["order"]["parts"]
    @city_capacity = Order.city_capacity current_city_id

    @auto = Auto.find_by id: params[:auto_id]

    activity = Activity.find_by id: params[:act]

    type = params["type"]

    payload = {
      parts: @parts
    }

    if activity && activity.valid_activity?
      payload[:discount] = activity.preferential_code
    end

    @cities = Order.cities
    @result = Order.refresh_price car_id, current_city_id, payload, type
  end

  def no_car_type
    @city_capacity = Order.city_capacity current_city_id
    @cities = Order.cities

    ## 临时的 ####
    payload = { parts: [], service_type: params[:type] }
    @result = Order.refresh_price "531f1fd2098e71b3f8003265", current_city_id, payload
    ##############

    if !browser.mobile?
      render layout: 'new'
    end
  end

  def submit_no_car_order

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:verification_code])

    if !params[:address].present?
      return render js: "$('#add_address_modal').modal();"
    end


    if !signed_in? && !(vcode && !vcode.expired?)
      return render "fail"
    end


    payload = {
      service_type: params[:service_type],
      "info" => {
        "address"           => params[:address],
        "name"              => params[:name],
        "phone_num"         => params[:phone_num],
        "car_location"      => params[:car_location],
        "car_num"           => params[:car_num],
        "serve_datetime"    => "#{params[:serve_date]} #{params[:serve_period]}",
        "client_comment"    => "#{params[:brand]} #{params[:year]} #{params[:car_pl]}",
        "city_id"           => params[:city_id],
        "registration_date" => params[:registration_date],
        "vin"               => params[:vin_num],
        "discount"          => params[:discount]
      }
    }

    result = Order.submit_no_car_order payload
    if result["result"] == "succeeded"

      unless signed_in?
        user = User.find_or_create_by(phone_number: vcode.phone_num)
        sign_in user
      end

      redirect_to action: :success
    else
      render "fail"
    end
  end

  def submit

    vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:verification_code])

    if !params[:address].present?
      return render js: "$('#add_address_modal').modal();"
    end

    city_name = params[:address][/.+?市/][0..-2]
    city = City.find_by(name: city_name)

    if !signed_in? && !(vcode && !vcode.expired?)
      return render js: "alert('请填写正确的验证码')"
    end

    if params[:parts]
      parts = params[:parts].values
    elsif cookies['parts']
      parts = JSON.parse cookies["parts"]
    else
      parts = []
    end

    # if !params[:serve_date].present?
    #   return render js: "alert('请填写正确的服务日期')"
    # end

    # if !params[:registration_date].present?
    #   return render js: "alert('请填写正确的车辆注册日期')"
    # end

    if !(params[:serve_date] && params[:serve_period])
      return render js: "alert('请选择正确的服务时间')"
    end

    if params[:type] == 'pm25'
      service_type = 0
    elsif params[:type] == 'bmt' || params[:type] == 'smt'
      service_type = 1
    elsif params[:type] == 'bty'
      service_type = 2
    end

    if !params[:reciept_title]
      reciept_type = 0
    else
      reciept_type = 1
    end

    payload = {
      parts: parts,
      service_type: service_type,
      info: {
        "address"           => params[:address],
        "name"              => params[:name],
        "phone_num"         => params[:phone_num],
        "car_location"      => params[:car_location],
        "car_num"           => params[:car_num],
        "serve_datetime"    => "#{params[:serve_date]} #{params[:serve_period]}",

        "reciept_type"      => reciept_type,
        "reciept_title"     => params[:reciept_title],

        "client_comment"    => params[:client_comment],
        "city_id"           => city.system_id, #params[:city_id]
        "car_id"            => params[:car_id],
        "registration_date" => params[:registration_date],
        "discount"          => params[:discount]
      }
    }

    activity = params[:act] && Activity.find_by_id(params[:act])
    payload[:info]["user_type_id"] = activity.from if activity

    result = Order.submit params[:car_id], payload
    if result["result"] == "succeeded"

      # find_or_create user
      user = current_user

      unless signed_in?
        user = User.find_or_create_by(phone_number: vcode.phone_num)
        sign_in user

        account = PublicAccount.find_by(name: "kaladingcom")
        authinfo = account.auth_infos.find_by \
          provider: "weixin",
          uid: cookies[:USERAUTH]

        if authinfo
          unless current_user.auth_infos.include? authinfo
            current_user.auth_infos << authinfo
          end
        end
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
    id = params[:id]
    @order = Order.find(id)['data']
  end

  def success
    if browser.mobile?
      render layout: "application"
    else
      render layout: 'new'
    end
  end

  def order_status
  end

  def destroy
    data = Order.cancel params[:id], params[:reason]
    # @order = Order.find(params[:id])['data']
    @order = Order.origin_find(params[:id])

    if data["result"] == "ok"
      render "destroy"
    else
      render js: "alert('取消失败, 请刷新重试')"
    end
  end
end
