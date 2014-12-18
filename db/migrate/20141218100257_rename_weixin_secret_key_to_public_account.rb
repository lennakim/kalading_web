class RenameWeixinSecretKeyToPublicAccount < ActiveRecord::Migration
  def change
    rename_column :public_accounts, :weixin_secret_key, :account_secret_key
  end
end
