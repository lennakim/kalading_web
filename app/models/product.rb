class Product < ActiveRecord::Base
  has_many :city_products
  has_many :cities, through: :city_products

  has_many :activity_products
  has_many :activities, through: :activity_products

  validates :slug, uniqueness: true, presence: true
end
