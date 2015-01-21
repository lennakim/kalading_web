class ChangeAuthinfoidFromAuthinfoActivity < ActiveRecord::Migration
  def change
    rename_column :authinfo_activities, :authinfo_id, :auth_info_id
  end
end
