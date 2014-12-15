class Admin::ChannelsController < Admin::HomeController
  inherit_resources

  defaults :resource_class => Channel, :route_prefix => 'admin'

  def permitted_params
    {:channel => params.fetch(:channel, {}).permit(:name)}
  end

end
