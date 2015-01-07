class ServiceAddressesController < ApplicationController
  inherit_resources

  def create
    if signed_in?
      address = current_user.service_addresses.create permitted_params[:service_address]
      current_user.set_default_address address
      render "create"
    else
      render js: "alert('login first')"
    end
  end

  def destroy
    current_user.service_addresses.destroy params[:id]
  end

  def set_default
    if signed_in?
      current_user.set_default_address ServiceAddress.find(params[:service_address_id])
      render js: "alert('设置成功')"
    else

    end
  end

  def permitted_params
    {:service_address => params.fetch(:service_address, {}).permit(:city, :detail)}
  end
end
