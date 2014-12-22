class ChangeAccountSecretKeyFromPublicAccount < ActiveRecord::Migration
  def change
    rename_column :public_accounts, :weixin_secret_key, :account_secret_key
    rename_column :public_accounts, :weixin_token, :account_token
  end
end
