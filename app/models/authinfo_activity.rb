class AuthinfoActivity < ActiveRecord::Base
  belongs_to :auth_info
  belongs_to :activity
end
