class RemoveCreateTimeFromRecvMessage < ActiveRecord::Migration
  def change
    remove_column :recv_messages, :create_time, :string
  end
end
