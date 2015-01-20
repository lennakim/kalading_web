class CreateActivityProducts < ActiveRecord::Migration
  def change
    create_table :activity_products do |t|
      t.references :activity, index: true
      t.references :product, index: true

      t.timestamps
    end
  end
end
