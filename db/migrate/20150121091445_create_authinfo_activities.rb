class CreateAuthinfoActivities < ActiveRecord::Migration
  def change
    create_table :authinfo_activities do |t|
      t.integer :authinfo_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
