class CitiesController < ApplicationController
  def set
    if signed_in?
      current_user.set_city params[:city_name]
      render json: { success: true }
    else
      render json: { success: false }
    end
  end
end
