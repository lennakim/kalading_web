class CitiesController < ApplicationController
  def set
    city = City.find params[:city_id]

    if signed_in?
      current_user.set_city city
    end

    cookies[:city_id] = { value: city.id, expires: 360.days.from_now }
    cookies[:set_city_manually] = { value: true, expires: 360.days.from_now }
  end

  def city_capacity
    city_name = params[:address][/.+?市/][0..-2]
    city = City.find_by(name: city_name)
    city_capacity = Order.city_capacity city.system_id

    render json: city_capacity
  end
end
