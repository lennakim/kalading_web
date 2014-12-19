class RemoveUserIdFromAuthInfo < ActiveRecord::Migration
  def change
    remove_column :auth_infos, :user_id, :integer
  end
end
