class RemoveTitleFromDiymenu < ActiveRecord::Migration
  def change
    remove_column :diymenus, :title, :string
  end
end
