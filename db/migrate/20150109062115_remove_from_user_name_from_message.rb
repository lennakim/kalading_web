class RemoveFromUserNameFromMessage < ActiveRecord::Migration
  def change
    remove_column :messages, :from_user_name, :string
  end
end
