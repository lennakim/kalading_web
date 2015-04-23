class UsersController < ApplicationController

  before_action :need_login, only: [:orders, :maintain_histories_list, :maintain_history, :settings, :update, :cars, :balance]

  def index
    redirect_to action: :orders
  end

  def orders
<<<<<<< HEAD
    pp current_user.phone_number
    @orders = Order.get_orders_of current_user.phone_number
=======
    @orders = Order.get_orders_of(current_user.phone_number)['data']
>>>>>>> 30d56cbd3dc60b520a6db680f2267d824af44796
  end

  def order_detail

  end

  def maintain_histories_list
    @maintain_orders = Order.maintain_histories_of current_user.phone_number
  end

  def maintain_history
    @maintain_history = Order.api_maintain_find params[:id]
  end

  def settings
    @cities = Order.cities
  end

  def update
    current_user.update_attributes permitted_params[:user]
    redirect_to settings_users_path
  end

  def cars
    @cars_info = Order.cars_data current_city_id
    @auto_id = params[:auto_id]
    @maintain_histories = Order.maintain_report login_phone_num: current_user.phone_number, car_id: params[:car_id], car_num: params[:car_num]
  end

  def balance
  end

  private

  def need_login
    unless signed_in?
      session[:from_path] = request.fullpath
      return redirect_to root_path(login: 1)
    end
  end

  def permitted_params
    {:user => params.fetch(:user, {}).permit(:username, :invoice_title)}
  end

end
