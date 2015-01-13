class Auto < ActiveRecord::Base
  belongs_to :user

  class << self
    def api_find id
      data = ServerApi.call "get", "auto_submodels", { entry_id: id }
      Auto.new brand: data["brand"], series: data["model"], model_number: data["name"], system_id: data["_id"]
    end
  end

  def full_name
    "#{ brand }#{ series }#{ model_number }"
  end
end
