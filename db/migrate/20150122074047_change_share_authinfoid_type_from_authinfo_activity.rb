class ChangeShareAuthinfoidTypeFromAuthinfoActivity < ActiveRecord::Migration
  def change
    change_column :authinfo_activities, :share_authinfoid, :integer
  end
end
