class HomeController < ApplicationController
  def index
  end

  def new_index
    if browser.mobile?
      if session[:from_path]
        return redirect_to action: :index, login: 1
      else
        return redirect_to action: :index
      end
    end
    render layout: "new"
  end
end
