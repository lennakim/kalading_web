class Activity::MainController < ActionController::Base
  layout "activity"
  impressionist

  before_action :find_activity

  def show
    impressionist(@activity, params[:from])

    if @activity && Time.now < @activity.end_date && Time.now > @activity.start_date
      render "#{@activity.name}"
    else
      render text: "no such activity"
    end
  end

  private

  def find_activity
    @activity = Activity.find_by name: params[:name]
    return render text: "no such activity" unless @activity
  end
end
