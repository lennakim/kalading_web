class ServiceAddress < ActiveRecord::Base
  belongs_to :user

  def full_address
    "[#{city}]#{detail}"
  end
end
