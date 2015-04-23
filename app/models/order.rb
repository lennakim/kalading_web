class Order

  class << self

    def submit_no_car_order payload
      ServerApi.call "post", "auto_maintain_order2", { body: payload }
    end

    def city_capacity city_id
      ServerApi.call "get", "city_capacity", { entry_id: city_id }
    end

    def comments
      ServerApi.call "get", "/api/v2/evaluations"
    end

    def auto_brands city_id
      ServerApi.call "get", "auto_brands", { city_id: city_id }
    end

    def auto_series brand_id, city_id
      ServerApi.call "get", "auto_brands", { entry_id: brand_id, city_id: city_id }
    end

    def auto_model_numbers series_id, city_id, type = "bmt"
      ServerApi.call "get", "auto_models", { entry_id: series_id, city_id: city_id, "#{type}" => true }
    end

    def recent_orders
      ServerApi.call 'get', 'latest_orders'
    end

    def cities
      ServerApi.call "get", "cities"
    end

    def cancel id, content
      payload = {
        order: { state: 8, cancel_reason: content }
      }
      ServerApi.call "put", "orders", { entry_id: id, body: payload }
    end

    def find id
      # ServerApi.call "get", "orders", { entry_id: id }
      ServerApi.call "get", "api/v2/orders", { entry_id: id }
    end

    def cars_data city_id, type = "bmt"
      if type == 'pm25'
        ServerApi.call "get", "auto_sms_with_pm25", {city_id: city_id}
      else
        ServerApi.call "get", "auto_brands", {all: 1, city_id: city_id}
      end
    end

    def items_for car_id, city_id, type = "bmt"

      ServerApi.call "get", "auto_maintain_order", { entry_id: car_id, city_id: city_id } {[]}
    end

    def refresh_price car_id, city_id, payload, type = "bmt"
      if type == 'pm25'
        service_type = 0
      elsif type == 'btm' || type == 'smt'
        service_type = 1
      elsif type == 'bty'
        service_type = 2
      end

      ServerApi.call "post", "auto_maintain_price", { entry_id: car_id, city_id: city_id, body: payload, service_type: service_type }
    end

    def submit car_id, payload
      ServerApi.call "post", "auto_maintain_order", { entry_id: car_id, body: payload }
    end

<<<<<<< HEAD
    # def get_orders_of phone_num = nil, client_id = nil, page = 1, per = 1000
    #   ServerApi.call "get", "orders", { login_phone_num: phone_num, client_id: client_id, page: page, per: per  }
    # end

    def get_orders_of phone_num = nil
      ServerApi.call "get", "api/v2/orders", { phone: phone_num }
=======
    def get_orders_of phone_num = nil, client_id = nil, page = 1, per = 1000
      # ServerApi.call "get", "orders", { login_phone_num: phone_num, client_id: client_id, page: page, per: per  }
      ServerApi.call "get", "api/v2/orders", { phone: phone_num  }
>>>>>>> 30d56cbd3dc60b520a6db680f2267d824af44796
    end

    def maintain_histories_of phone_num = nil, client_id = nil, page = 1, per = 1000
      ServerApi.call "get", "auto_inspection_report", { login_phone_num: phone_num, client_id: client_id, page: page, per: per  }
    end

    def maintain_report queries
      ServerApi.call "get", "auto_inspection_report", queries
    end

    def api_maintain_find id
      ServerApi.call "get", "maintains", { entry_id: id }
    end

    def submit_special_order payload
      ServerApi.call 'post', 'auto_special_order', { body: payload } {{}}
    end

    def comment order_id, desc, score
      #ServerApi.call "put", "orders", { entry_id: order_id, body: payload }
      ServerApi.call "post", "api/v2/evaluations", { body:{ order_id: order_id, desc: desc, score: score } }
    end

  end

end
