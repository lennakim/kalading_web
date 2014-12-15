class AddNameToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :name, :string
    add_index :public_accounts, :name, :unique => true
  end
end
