class Admin::QrcodesController < Admin::MainController
  def index
    account = PublicAccount.find_by(name:"kalading1")
    @client = account.weixin_client
    @index = 1..100
  end
end
