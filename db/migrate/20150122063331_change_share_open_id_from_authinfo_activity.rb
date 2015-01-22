class ChangeShareOpenIdFromAuthinfoActivity < ActiveRecord::Migration
  def change
    change_column :authinfo_activities, :share_openid, :string
  end
end
