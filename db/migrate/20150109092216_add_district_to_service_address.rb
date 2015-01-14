class AddDistrictToServiceAddress < ActiveRecord::Migration
  def change
    add_column :service_addresses, :district, :string
  end
end
