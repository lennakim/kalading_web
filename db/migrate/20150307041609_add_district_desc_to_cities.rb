class AddDistrictDescToCities < ActiveRecord::Migration
  def change
    add_column :cities, :district_desc, :string
  end
end
