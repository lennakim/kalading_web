class Post < ActiveRecord::Base
  acts_as_taggable
  scope :desc, ->{ order("created_at desc") }
end
