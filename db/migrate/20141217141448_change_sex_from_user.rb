class ChangeSexFromUser < ActiveRecord::Migration
  def change
    change_column :users, :sex, :string
  end
end
