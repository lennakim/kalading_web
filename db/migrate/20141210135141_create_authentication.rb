class CreateAuthentication < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true, null: false
      t.string :provider
      t.string :uid
      t.string :token
      t.datetime :expires_at
    end
    add_index :authentications, :uid
  end
end
