require "#{Rails.root}/lib/server_api.rb"

class Order

  class << self
    def cars_data
      ServerApi.call "get", "auto_brands", {all: 1}
    end

    def items_for car_id
      ServerApi.call "get", "auto_maintain_order", {entry_id: car_id} {[]}
    end
  end

end
