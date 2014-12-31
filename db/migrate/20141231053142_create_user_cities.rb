class CreateUserCities < ActiveRecord::Migration
  def change
    create_table :user_cities do |t|
      t.references :user, index: true
      t.references :city, index: true

      t.timestamps
    end
  end
end
