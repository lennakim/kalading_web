class AddBasicInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :invoice_title, :string
  end
end
