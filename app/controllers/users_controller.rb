class UsersController < ApplicationController

  def orders
    # phone_nums = params[:phone_nums]
    @orders = Order.get_orders_of '13333333333'
    # @orders = Order.get_orders_of '13111111111'
  end

  def maintain_histories
  end

  def i
  end

  def cars
    @cars_info = Order.cars_data

    @maintain_histories = Order.maintain_histories_of '13111111111'
  end

  def balance
  end

end
