class RenameContentFromMessage < ActiveRecord::Migration
  def change
    rename_column :messages, :contnet, :content
  end
end
