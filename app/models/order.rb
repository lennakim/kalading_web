require "#{Rails.root}/lib/server_api.rb"

class Order

  class << self
    def cars_data
      ServerApi.call "get", "auto_brands", {all: 1}
    end

    def items_for car_id
      ServerApi.call "get", "auto_maintain_order", {entry_id: car_id} {[]}
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
  end

end
