class AddTwoColumnsIndexToAuthInfo < ActiveRecord::Migration
  def change
    add_index :auth_infos, [:provider, :uid]
  end
end
