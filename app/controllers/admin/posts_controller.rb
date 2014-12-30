class Admin::PostsController < Admin::MainController
  inherit_resources

  defaults :resource_class => Post, :route_prefix => 'admin'
end
