class AutosController < ApplicationController
  inherit_resources

  def create
  end

  def permitted_params
    {:auto => params.fetch(:auto, {}).permit(:system_id, :brand, :series, :model_number, :registed_at, :engine_number, :vin, :license_number, :license_location)}
  end
end
