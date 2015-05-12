class AddLogoToAuto < ActiveRecord::Migration
  def change
    add_column :autos, :logo, :string
  end
end
