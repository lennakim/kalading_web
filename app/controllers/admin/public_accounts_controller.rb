class Admin::PublicAccountsController < Admin::MainController
  def new
    @account = PublicAccount.find_by(name: "kalading1")
  end
end
