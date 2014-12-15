class Activity < ActiveRecord::Base
  validates :name, presence: true

  is_impressionable counter_cache: true
end
