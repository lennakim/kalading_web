class RemoveHeadimgurlFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :headimgurl, :string
  end
end
