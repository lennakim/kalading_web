class Admin::DiymenusController < Admin::MainController
  def index
    @hello = "hello,world"
  end
  def new
    @account = PublicAccount.find_by(name: "kalading1")
    @diymenu = @account.diymenus.new
  end
end
