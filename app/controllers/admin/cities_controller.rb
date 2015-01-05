class Admin::CitiesController < Admin::MainController
  inherit_resources

  defaults :resource_class => City, :route_prefix => 'admin'

  def permitted_params
    {:city => params.fetch(:city, {}).permit(:name, :system_id)}
  end

end
