class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :street
      t.references :user, index: true

      t.timestamps
    end
  end
end
