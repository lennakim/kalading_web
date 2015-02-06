class ServiceAddress < ActiveRecord::Base
  belongs_to :user

  def full_address
    # "[#{city}#{district}]#{detail}"

    if !(detail =~ /#{city}#{district}/)
      "#{city}#{district}#{detail}"
    else
      detail
    end
  end
end
