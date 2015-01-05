class Admin::PublicAccountsController < Admin::MainController

  before_action :set_account, only: [:diy_menu, :edit_menu, :update_menu, :apply_menu]

  def diy_menu
  end

  def edit_menu
  end

  def update_menu
    @account.update_attributes menu_params
    redirect_to diy_menu_admin_public_accounts_path
  end

  def apply_menu
    client = @account.weixin_client
    client.create_menu(@account.build_menu)
    redirect_to diy_menu_admin_public_accounts_path
  end

  private

  def set_account
    @account = PublicAccount.find_by(name: "kalading1")
  end

  def menu_params
    params.require(:public_account).permit(diymenus_attributes: [:id, :key, :name, :url, :is_show, :_destroy, sub_menus_attributes: [:id, :key, :name, :url, :is_show, :_destroy]])
  end

end
