class CityProduct < ActiveRecord::Base
  belongs_to :city
  belongs_to :product
end
