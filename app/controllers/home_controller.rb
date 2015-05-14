class HomeController < ApplicationController
  def index
  end

  def new_index
    if browser.mobile?
      return redirect_to action: :index
    end
    render layout: "new"
  end
end
