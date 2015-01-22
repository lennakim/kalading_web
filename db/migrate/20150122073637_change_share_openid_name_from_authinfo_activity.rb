class ChangeShareOpenidNameFromAuthinfoActivity < ActiveRecord::Migration
  def change
    rename_column :authinfo_activities, :share_openid, :share_authinfoid
  end
end
