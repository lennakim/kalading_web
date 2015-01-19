class Activity < ActiveRecord::Base
  validates :name, presence: true

  is_impressionable counter_cache: true

  has_many :activity_products
  has_many :products, through: :activity_products

end
