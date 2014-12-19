class CreateUserAuthinfos < ActiveRecord::Migration
  def change
    create_table :user_authinfos do |t|
      t.integer :user_id
      t.integer :auth_info_id

      t.timestamps
    end
  end
end
