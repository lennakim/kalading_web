class Admin::PostsController < Admin::MainController
  inherit_resources

  defaults :resource_class => Post, :route_prefix => 'admin'

  def permitted_params
    {:post => params.fetch(:post, {}).permit(:title, :content, :tag_list, :slug)}
  end

  protected

  def collection
    end_of_association_chain.desc.page(params[:page])
  end
end
