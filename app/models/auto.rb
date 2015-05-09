class Auto < ActiveRecord::Base
  scope :recent, -> {order(created_at: :desc)}

  belongs_to :user

  class << self
    def api_find id
      data = ServerApi.call "get", "auto_submodels", { entry_id: id }
      Auto.new brand: data["brand"], series: data["model"], model_number: data["name"], system_id: data["_id"]
    end

    def find_by_api id #使用原生数据 业务需求照片
      data = ServerApi.call "get", "auto_submodels", { entry_id: id }
      ActiveSupport::JSON.decode(data.to_json)
    end

  end

  def full_name
    "#{ brand }#{ series }#{ model_number }"
  end
end
