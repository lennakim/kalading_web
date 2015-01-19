class AddPreferentialCodeToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :preferential_code, :string
  end
end
