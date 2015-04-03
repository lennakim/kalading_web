class AddIndexToReplyMessage < ActiveRecord::Migration
  def change
    add_index :reply_messages, :keyword
  end
end
