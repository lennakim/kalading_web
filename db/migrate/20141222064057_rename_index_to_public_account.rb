class RenameIndexToPublicAccount < ActiveRecord::Migration
  def change
    rename_index :public_accounts, :weixin_secret_key, :account_secret_key
    rename_index :public_accounts, :weixin_token, :account_token
  end
end
