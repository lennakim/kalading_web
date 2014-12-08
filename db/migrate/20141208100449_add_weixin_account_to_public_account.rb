class AddWeixinAccountToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :weixin_id, :string
    add_column :public_accounts, :appid, :string
    add_column :public_accounts, :appsecret, :string
  end
end
