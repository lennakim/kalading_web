class RemovePublicAccountIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :public_account_id, :integer
  end
end
