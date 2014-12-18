class RemoveSexFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :sex, :string
  end
end
