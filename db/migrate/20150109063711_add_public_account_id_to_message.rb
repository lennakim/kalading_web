class AddPublicAccountIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :public_account_id, :integer
  end
end
