class RemoveSubscribeTimeFromUser < ActiveRecord::Migration
  def change
    remove_column :Users, :subscribe_time, :datetime
  end
end
