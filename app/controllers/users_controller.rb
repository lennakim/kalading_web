class UsersController < ApplicationController

  def index
    redirect_to action: :orders
  end

  def orders
    @orders = Order.get_orders_of current_user.phone_number
  end

  def maintain_histories_list

    redirect_to root_path(login: 1) unless signed_in?

    @maintain_orders = Order.maintain_histories_of current_user.phone_number
  end

  def maintain_history
    redirect_to root_path(login: 1) unless signed_in?
    @maintain_history = Order.api_maintain_find params[:id]
  end

  def settings
    redirect_to root_path(login: 1) unless signed_in?
    @cities = Order.cities
  end

  def update
    current_user.update_attributes permitted_params[:user]
    redirect_to settings_users_path
  end

  def cars
    redirect_to root_path(login: 1) unless signed_in?
    @cars_info = Order.cars_data current_city_id
    @auto_id = params[:auto_id]
    @maintain_histories = Order.maintain_report login_phone_num: current_user.phone_number, car_id: params[:car_id], car_num: params[:car_num]
  end

  def balance
  end

  def permitted_params
    {:user => params.fetch(:user, {}).permit(:username, :invoice_title)}
  end

end
