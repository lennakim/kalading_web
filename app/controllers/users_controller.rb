class UsersController < ApplicationController

  def orders
    # phone_nums = params[:phone_nums]
    @orders = Order.get_orders_of '13333333333'
    pp @orders
  end

  def maintain_histories
  end

  def cars
  end

  def balance
  end

end
