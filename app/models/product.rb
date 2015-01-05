class Product < ActiveRecord::Base
  has_many :city_products
  has_many :cities, through: :city_products

  validates :slug, uniqueness: true, presence: true
end
