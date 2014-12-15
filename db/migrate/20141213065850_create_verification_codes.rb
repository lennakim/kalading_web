class CreateVerificationCodes < ActiveRecord::Migration
  def change
    create_table :verification_codes do |t|
      t.string :phone_num
      t.string :code
      t.datetime :expires_at

      t.timestamps
    end
    add_index :verification_codes, :phone_num
    add_index :verification_codes, :code
  end
end
