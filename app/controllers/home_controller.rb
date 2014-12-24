class HomeController < ApplicationController
  def index
    Rails.logger.info("*******************#{cookies[:USERAUTH]}")
  end
end
