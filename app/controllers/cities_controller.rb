class CitiesController < ApplicationController
  def set
    city = City.find params[:city_id]

    if signed_in?
      current_user.set_city city
    end

    cookies[:city_id] = { value: city.id, expires: 360.days.from_now }
    cookies[:set_city_manually] = { value: true, expires: 360.days.from_now }
  end
end
