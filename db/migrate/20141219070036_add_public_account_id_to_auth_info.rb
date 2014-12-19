class AddPublicAccountIdToAuthInfo < ActiveRecord::Migration
  def change
    add_column :auth_infos, :public_account_id, :integer
  end
end
