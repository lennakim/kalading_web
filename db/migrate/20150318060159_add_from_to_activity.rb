class AddFromToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :from, :string
  end
end
