class Admin::PostsController < Admin::MainController
  inherit_resources

  defaults :resource_class => Post, :route_prefix => 'admin'

  def permitted_params
    {:post => params.fetch(:post, {}).permit(:title, :content, :tag_list)}
  end
end
