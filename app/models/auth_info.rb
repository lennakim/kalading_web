class AuthInfo < ActiveRecord::Base
  belongs_to :public_account
  has_many :user_authinfos
  has_many :users, through: :user_authinfos

  has_many :authinfo_activities
  has_many :activities, through: :authinfo_activities


  has_many :share_authinfo_activities, class_name: "AuthinfoActivity", foreign_key: "share_authinfo_id"
  has_many :share_authinfos, through: :share_authinfo_activities, source: "auth_info"

  validates_uniqueness_of :provider, :scope => [:uid]
  validates :provider, :uid,  presence:true

end
