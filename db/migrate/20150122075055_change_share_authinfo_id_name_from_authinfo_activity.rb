class ChangeShareAuthinfoIdNameFromAuthinfoActivity < ActiveRecord::Migration
  def change
    rename_column :authinfo_activities, :share_authinfoid, :share_authinfo_id
  end
end
