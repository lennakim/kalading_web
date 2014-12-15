class AddIndexToPublicAccount < ActiveRecord::Migration
  def change
    add_index :public_accounts, :weixin_id, :unique => true
  end
end
