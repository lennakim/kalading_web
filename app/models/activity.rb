class Activity < ActiveRecord::Base
  validates :name, presence: true

  is_impressionable counter_cache: true

  has_many :activity_products
  has_many :products, through: :activity_products

  has_many :authinfo_activities
  has_many :auth_infos, through: :authinfo_activities

  def valid_activity?
    Time.now < end_date && Time.now > start_date
  end

end
