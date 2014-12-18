class RemoveProvinceFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :province, :string
  end
end
