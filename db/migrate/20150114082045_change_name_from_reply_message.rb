class ChangeNameFromReplyMessage < ActiveRecord::Migration
  def change
    rename_column :reply_messages, :name, :keyword
  end
end
