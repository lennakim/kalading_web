class RenamePublicAccountFromUser < ActiveRecord::Migration
  def change
    rename_column :users, :publicaccount_id, :public_account_id
  end
end
