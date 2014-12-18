class RenamePlatformToAuthInfo < ActiveRecord::Migration
  def change
    rename_table :platforms, :auth_infos
  end
end
