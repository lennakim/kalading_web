class RemoveToUserNameFromReplyMessage < ActiveRecord::Migration
  def change
    remove_column :reply_messages, :to_user_name
  end
end
