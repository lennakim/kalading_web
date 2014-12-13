class Traffic < ActiveRecord::Base
  belongs_to :activity
  belongs_to :channel
end
