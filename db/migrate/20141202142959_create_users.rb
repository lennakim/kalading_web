class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :subscribe
      t.integer :openid
      t.string :nickname
      t.string :sex
      t.string :city
      t.string :country
      t.string :province
      t.string :language
      t.string :headimgurl
      t.datetime :subscribe_time

      t.timestamps
    end
  end
end
