class Admin::ProductsController < Admin::MainController
  inherit_resources

  defaults :resource_class => Product, :route_prefix => 'admin'

  def permitted_params
    {product: params.fetch(:product, {}).permit(:title, :description, :slug, city_ids: [])}
  end
end
