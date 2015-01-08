class OrdersController < ApplicationController

  def select_car
    type = params[:type]
    @cars_info = Order.cars_data type
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

    # {"utf8"=>"✓",
    # "authenticity_token"=>"m66wRe0W++ispfMqyboT8C0Pe/XdvACmVTiMigrr7uU=",
    # "car_id"=>"531f1f84098e71b3f800247d",
    # "parts"=>{"0"=>{"brand"=>"汉格斯特 Hengst", "number"=>"5280cb9d098e71d85e000580"}, "1"=>{"brand"=>"汉格斯特 Hengst", "number"=>"5280cb91098e71d85e0001d0"}, "2"=>{"brand"=>"曼牌 Mann", "number"=>"5246c7ee098e7109280001d7"}, "3"=>{"brand"=>"[需和空调滤清器同时购买]", "number"=>"53672bab9a94e45d440005ae"}, "4"=>{"brand"=>"嘉实多", "number"=>"磁护 SN 5W-40"}},
    #
    # "address"=>"24",
    # "name"=>"aaa",
    # "car_num"=>"",
    # "serve_datetime"=>"2015-01-14",
    # "pay_type"=>"",
    # "registration_date"=>"2015-01-06",
    # "engine_num"=>"",
    # "vin"=>"",
    # "invoice"=>"",
    # "unit"=>"",

    # "utf8"=>"✓", "authenticity_token"=>"m66wRe0W++ispfMqyboT8C0Pe/XdvACmVTiMigrr7uU=",
    #
    # "phone_num"=>"15666300899",
    # "car_id"=>"531f1f84098e71b3f800247d",
    # "parts"=>{"0"=>{"brand"=>"汉格斯特 Hengst", "number"=>"5280cb9d098e71d85e000580"}, "1"=>{"brand"=>"汉格斯特 Hengst", "number"=>"5280cb91098e71d85e0001d0"}, "2"=>{"brand"=>"曼牌 Mann", "number"=>"5246c7ee098e7109280001d7"}, "3"=>{"brand"=>"[需和空调滤清器同时购买]", "number"=>"53672bab9a94e45d440005ae"}, "4"=>{"brand"=>"嘉实多", "number"=>"磁护 SN 5W-40"}},
    #
    # "address"=>"[北京市]北京市海淀区北京市海淀区社保中心",
    # "name"=>"congteng",
    # "car_location"=>"京",
    # "car_num"=>"123456",
    #
    # "serve_date"=>"2015-01-14",
    # "serve_period"=>"8:00 - 12:00",
    # "pay_type"=>"1",
    # "registration_date"=>"2015-01-06",
    # "engine_num"=>"11111",
    #
    # "vin"=>"22222",
    # "invoice"=>"", "unit"=>"", "preferential"=>"", "client_comment"=>"", "commit"=>"提交订单", "action"=>"submit", "controller"=>"orders"

    payload = {
      parts: params[:parts].values,
      info: {
        "address"        => params[:address],
        "name"           => params[:name],
        "phone_num"      => params[:phone_num],
        "client_id"      => params[:car_id],
        "car_location"   => params[:car_location],
        "car_num"        => params[:car_num],
        "serve_datetime" => "#{params[:serve_date]} #{params[:serve_period]}",
        "pay_type"       => params[:pay_type],
        "reciept_type"   => 1,
        "reciept_title"  => "卡拉丁汽车技术",
        "client_comment" => params[:client_comment],
        "city_id"        => params[:city_id]
      }
    }



    # json_data = '
    #   "parts": [
    #     {
    #       "brand": "曼牌 Mann",
    #       "number": "528af433098e7180590042ca"
    #     },
    #     {
    #       "brand": "卡拉丁",
    #       "number": "53672bab9a94e45d440005ae"
    #     }
    #   ],
    #   "info": {
    #     "address": "北京朝阳区光华路888号",
    #     "name": "王一迅",
    #     "phone_num": "13888888888",
    #     "client_id": "040471abcd",
    #     "car_location": "京",
    #     "car_num": "N333M3",
    #     "serve_datetime": "2014-06-09 15:44",
    #     "pay_type": 1,
    #     "reciept_type": 1,
    #     "reciept_title": "卡拉丁汽车技术",
    #     "client_comment": "请按时到场",
    #     "city_id": "5307033e098e719c45000043"
    #   }
    # }
    # '


    Rails.logger.info payload

    Order.submit params[:car_id], payload
  end

  def show
  end

end
