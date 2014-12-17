class UsersController < ApplicationController

  def orders
    # phone_nums = params[:phone_nums]
    @orders = Order.get_orders_of '13333333333'
  end

  def maintain_histories
  	@maintain_orders = Order.maintain_histories_of '13111111111'
  end

  def cars
    
  end
  
  def new
    @cars_info = Order.cars_data
    pp @cars_info
  end 

  def balance
  end

end
