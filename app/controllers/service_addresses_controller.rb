class ServiceAddressesController < ApplicationController
  inherit_resources

  def create
    if signed_in?
      address = current_user.service_addresses.create permitted_params[:service_address]

      # set as default
      # current_user.set_default_address address

      render "create"
    else
      render js: "alert('login first')"
    end
  end

  def set_default
    # ...
  end

  def permitted_params
    {:service_address => params.fetch(:service_address, {}).permit(:city, :detail)}
  end
end
