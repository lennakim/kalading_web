class Auto < ActiveRecord::Base
  scope :recent, -> {order(created_at: :desc)}

  belongs_to :user

  class << self
    def api_find id
      data = ServerApi.call "get", "auto_submodels", { entry_id: id }

      logo = data['pictures'][0]['url'] if data['pictures'][0]
      Auto.new brand: data["brand"], series: data["model"], model_number: data["name"], system_id: data["_id"], logo: logo
    end
  end

  def full_name
    "#{ brand }#{ series }#{ model_number }"
  end
end
