class Admin::PublicAccountsController < Admin::MainController

  def diy_menu
    @account = PublicAccount.find_by(name: "kalading1")
  end

  def edit_menu
    @account = PublicAccount.find_by(name: "kalading1")
  end

  def update_menu
    account = PublicAccount.find_by(id: params[:id])
    account.update_attributes menu_params
    client = account.weixin_client
    client.create_menu(account.build_menu)

    redirect_to admin_diy_menu_path
  end

  private

  def menu_params
    params.require(:public_account).permit(diymenus_attributes: [:id, :key, :name, :url, :is_show, :_destroy, sub_menus_attributes: [:id, :key, :name, :url, :is_show, :_destroy]])
  end

end
