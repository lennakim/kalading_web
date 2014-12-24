class UserAuthinfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :auth_info
  validates :user_id, :auth_info_id, presence: true
end
