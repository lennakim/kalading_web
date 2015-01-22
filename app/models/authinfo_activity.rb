class AuthinfoActivity < ActiveRecord::Base
  belongs_to :auth_info
  belongs_to :activity

  belongs_to :share_authinfo, class_name: "AuthInfo"
end
