class RemoveSubscribeFromUser < ActiveRecord::Migration
  def change
    remove_column :Users, :subscribe, :string
  end
end
