class StaticPagesController < ApplicationController

  layout "new"

  def show
    @static_pages = params[:id]
  end
end
