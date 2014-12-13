class Activity < ActiveRecord::Base
  validates :name, presence: true

  has_many :traffics
  has_many :channels, throught: :traffics

end
