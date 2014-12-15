class AddTitleToDiymenu < ActiveRecord::Migration
  def change
    add_column :diymenus, :title, :string
  end
end
