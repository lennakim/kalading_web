class Admin::ActivitiesController < Admin::HomeController

  inherit_resources

  defaults :resource_class => Activity, :route_prefix => 'admin'

  def permitted_params
    {:activity => params.fetch(:activity, {}).permit(:name, :start_date, :end_date)}
  end

end

