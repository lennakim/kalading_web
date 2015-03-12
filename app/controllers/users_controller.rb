class UsersController < ApplicationController

  before_action :need_login, only: [:orders, :maintain_histories_list, :maintain_history, :settings, :update, :cars, :balance]

  def index
    redirect_to action: :orders
  end

  def orders
    # @orders = Order.get_orders_of current_user.phone_number

    @orders = [
      {"id"=>"54ff0d72cc03d377ae000017", "seq"=>2501, "name"=>"congteng1", "address"=>"北京市海淀区苏州街-地铁站", "phone_num"=>"15666300899", "auto_km"=>"", "vin"=>"", "car_num"=>"京PK4541", "client_comment"=>"", "state"=>"未预约", "serve_datetime"=>"2015-03-13 12:00", "auto_model"=>"奥迪(进口) A6  1.8L 1997.07-2005.01", "service_types"=>[{"name"=>"换机油机滤"}], "parts"=>[{"brand"=>"曼牌 Mann", "type"=>"空气滤清器", "number"=>"C 26 168（LX1681）", "price"=>52.0}, {"brand"=>"汉格斯特 Hengst", "type"=>"机滤", "number"=>"H14W27", "price"=>49.0}, {"brand"=>"美孚", "type"=>"机油", "number"=>"美孚1号 0W-40 1升", "price"=>85.0}, {"brand"=>"卡拉丁", "type"=>"空调滤清器", "number"=>"KC-620", "price"=>119.0}], "price"=>795.0, "balance_pay"=>0.0, "pay_type"=>"现金", "cancel_reason"=>"", "part_deliver_state"=>0, "reciept_need"=>false, "evaluated"=>0, "asm_pics"=>[], "served_engineers"=>[]}
    ]
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
