class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :service_addresses do |t|
      t.string :city
      t.string :detail
      t.references :user, index: true

      t.timestamps
    end
  end
end
