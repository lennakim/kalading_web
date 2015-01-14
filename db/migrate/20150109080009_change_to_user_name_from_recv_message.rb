class ChangeToUserNameFromRecvMessage < ActiveRecord::Migration
  def change
    rename_column :recv_messages, :to_user_name, :from_user_name
  end
end
