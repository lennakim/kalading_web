class Admin::UsersController < Admin::MainController

  inherit_resources
  defaults resource_class: User, route_prefix: 'admin'

  protected

  def collection
    end_of_association_chain.recent.page(params[:page])
  end

end
