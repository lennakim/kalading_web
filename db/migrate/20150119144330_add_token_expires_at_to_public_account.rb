class AddTokenExpiresAtToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :token_expires_at, :datetime
  end
end
