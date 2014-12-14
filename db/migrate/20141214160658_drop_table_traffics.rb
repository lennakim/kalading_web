class DropTableTraffics < ActiveRecord::Migration
  def change
    drop_table :traffics
  end
end
