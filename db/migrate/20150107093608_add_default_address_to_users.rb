class AddDefaultAddressToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :default_address, index: true
  end
end
