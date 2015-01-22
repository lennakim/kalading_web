class AddShareOpenidToAuthinfoActivity < ActiveRecord::Migration
  def change
    add_column :authinfo_activities, :share_openid, :integer
  end
end
