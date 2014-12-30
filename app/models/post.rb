class Post < ActiveRecord::Base
  scope :desc, ->{ order("created_at desc") }
end
