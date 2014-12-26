class UserAuthinfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :auth_info
  validates :user_id, :auth_info_id, presence: true

  validates :user_id, uniqueness: { scope: :auth_info_id, message: "user_id and auth_info_id should be uniqueness" }
end
