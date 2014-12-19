class UserAuthinfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :auth_info, dependent: :destroy
end
