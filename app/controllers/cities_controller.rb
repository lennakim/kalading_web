class CitiesController < ApplicationController
  def set
    city = City.find params[:city_id]

    if signed_in?
      current_user.set_city city
    end

    cookies[:city_id] = city.id
    cookies[:set_city_manually] = true
  end
end
