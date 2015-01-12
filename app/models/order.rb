class Order

  class << self

    def comments
      ServerApi.call "get", "order_evaluation_list"
    end

    def auto_brands
      ServerApi.call "get", "auto_brands"
    end

    def auto_series brand_id
      ServerApi.call "get", "auto_brands", { entry_id: brand_id }
    end

    def auto_model_numbers series_id
      ServerApi.call "get", "auto_models", { entry_id: series_id }
    end

    def recent_orders
      ServerApi.call 'get', 'latest_orders'
    end

    def cities
      ServerApi.call "get", "cities"
    end

    def cancel id
      payload = {
        order: { state: 8, cancel_reason: '有事先不做了' }
      }
      ServerApi.call "put", "orders", { entry_id: id, body: payload }
    end

    def find id
      get_orders_of("15666300899").first
    end

    def cars_data type = "bmt"
      ServerApi.call "get", "auto_brands", {all: 1, "#{type}" => true}
    end

    def items_for car_id
      ServerApi.call "get", "auto_maintain_order", { entry_id: car_id } {[]}
    end

    def refresh_price car_id, payload
      ServerApi.call "post", "auto_maintain_price", { entry_id: car_id, body: payload }
    end

    def submit car_id, payload
      ServerApi.call "post", "auto_maintain_order", { entry_id: car_id, body: payload }
    end

    def get_orders_of phone_num = nil, client_id = nil, page = 1, per = 1000
      ServerApi.call "get", "orders", { login_phone_num: phone_num, client_id: client_id, page: page, per: per  }
    end

    def maintain_histories_of phone_num = nil, client_id = nil, page = 1, per = 1000
      ServerApi.call "get", "auto_inspection_report", { login_phone_num: phone_num, client_id: client_id, page: page, per: per  }
    end

    def submit_special_order payload
      ServerApi.call 'post', 'auto_special_order', { body: payload } {{}}
    end

    def comment order_id, payload
      ServerApi.call "put", "orders", { entry_id: order_id, body: payload }
    end
  end

end
