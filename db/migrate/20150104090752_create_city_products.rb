class CreateCityProducts < ActiveRecord::Migration
  def change
    create_table :city_products do |t|
      t.references :city, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
