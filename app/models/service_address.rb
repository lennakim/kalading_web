class ServiceAddress < ActiveRecord::Base
  belongs_to :user

  def full_address
    "[#{city}#{district}]#{detail}"
  end
end
