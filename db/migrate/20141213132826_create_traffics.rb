class CreateTraffics < ActiveRecord::Migration
  def change
    create_table :traffics do |t|
      t.references :activity, index: true
      t.references :channel, index: true

      t.timestamps
    end
  end
end
