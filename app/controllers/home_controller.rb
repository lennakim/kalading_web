class HomeController < ApplicationController
  def index
  end

  def new_index
    render layout: "new"
  end
end
