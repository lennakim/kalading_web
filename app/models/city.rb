class City < ActiveRecord::Base

  has_many :users

  has_many :city_products
  has_many :products, through: :city_products

end
