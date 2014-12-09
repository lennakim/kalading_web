class AddIndexToMessage < ActiveRecord::Migration
  def change
    add_index :messages, :msg_id, :unique => true
  end
end
