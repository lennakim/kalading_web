class CreateAutos < ActiveRecord::Migration
  def change
    create_table :autos do |t|

      t.string :system_id
      t.string :brand
      t.string :series
      t.string :model_number
      t.date :registed_at
      t.string :engine_number
      t.string :vin
      t.string :license_location
      t.string :license_number
      t.references:user, index: true

      t.timestamps
    end
  end
end
