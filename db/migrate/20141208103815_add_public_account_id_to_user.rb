class AddPublicAccountIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :publicaccount_id, :integer
  end
end
