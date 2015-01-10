class Auto < ActiveRecord::Base
  belongs_to :user

  class << self
    def api_find id
      ServerApi.call "get", "auto_submodels", { entry_id: id }
    end
  end
end
