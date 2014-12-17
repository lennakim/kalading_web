class RemoveOpenidFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :openid, :string
  end
end
