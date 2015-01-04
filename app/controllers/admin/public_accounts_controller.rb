class Admin::PublicAccountsController < Admin::MainController

  before_action :set_account, only: [:new, :edit, :update, :destroy, :apply]

  def create
    # render plain: params.inspect
  end

  def update
    render plain: menu_params
  end

  private

  def set_account
    @account = PublicAccount.find_by(name: "kalading1")
  end

  def menu_params
    params.require(:public_account).permit(diymenus_attributes: [:id, :key, :name, :url, :is_show, :_destroy, sub_menus_attributes: [:id, :key, :name, :url, :is_show, :_destroy]])
  end

end
