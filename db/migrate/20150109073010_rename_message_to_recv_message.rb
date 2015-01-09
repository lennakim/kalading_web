class RenameMessageToRecvMessage < ActiveRecord::Migration
  def change
    rename_table :messages, :recv_messages
  end
end
