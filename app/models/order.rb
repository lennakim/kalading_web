require "#{Rails.root}/lib/server_api.rb"

class Order < ActiveRecord::Base

  class << self
    def cars_data
      ServerApi.call "get", "auto_brands", {all: 1}
    end
  end

end
