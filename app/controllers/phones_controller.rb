class PhonesController < ApplicationController

  def create
    if vcode = VerificationCode.find_by(phone_num: params[:phone_num], code: params[:code])

      # create a order to backend
      car_license = params[:car_license]
      ServerApi.call 'orders', {}

      render json: { success: true }
    end

  end

  def send_verification_code
    if VerificationCode.create(phone_num: params[:phone_num])
      render json: { success: true }
    else
      render json: { success: false }
    end
  end

end
