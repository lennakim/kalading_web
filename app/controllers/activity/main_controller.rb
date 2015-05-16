class Activity::MainController < ActionController::Base
  layout "activity"
  # impressionist

  before_action :find_activity, only: ['show']

  def show
    # impressionist(@activity, params[:from])

    if @activity && @activity.valid_activity?
      render "#{@activity.name}"
    else
      render text: "此活动已经下线了哦，请持续关注我们的官网，将会有更多精彩活动等着你！"
    end
  end

  def select_city
    @cities = City.all
  end

  private

  def find_activity
    @activity = Activity.find_by name: params[:name]
    return render text: "不存在这个活动" unless @activity
  end
end
