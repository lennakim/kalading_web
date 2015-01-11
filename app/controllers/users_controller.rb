class UsersController < ApplicationController

  def index
    redirect_to action: :orders
  end

  def orders
    # phone_nums = params[:phone_nums]
    @orders = Order.get_orders_of current_user.phone_number
    # @orders = Order.get_orders_of '13111111111'
  end

  def maintain_histories_list
    @maintain_orders = Order.maintain_histories_of current_user.phone_number
  end

  def maintain_histories
    @maintain_orders = Order.maintain_histories_of current_user.phone_number
  end

  def settings
    @cities = Order.cities
  end

  def update
    current_user.update_attributes permitted_params[:user]
    redirect_to settings_users_path
  end

  def cars
    @cars_info = Order.cars_data
    @maintain_histories = Order.maintain_histories_of current_user.phone_number
  end

  def balance
  end

  def permitted_params
    {:user => params.fetch(:user, {}).permit(:username, :invoice_title)}
  end

end
