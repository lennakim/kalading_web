class RenameAuthenticationToPlatform < ActiveRecord::Migration
  def change
    rename_table :authentications, :platforms
  end
end
