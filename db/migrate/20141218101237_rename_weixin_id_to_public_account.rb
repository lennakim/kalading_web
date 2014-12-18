class RenameWeixinIdToPublicAccount < ActiveRecord::Migration
  def change
    rename_column :public_accounts, :weixin_id, :account_id
  end
end
