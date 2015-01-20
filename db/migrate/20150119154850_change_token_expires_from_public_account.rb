class ChangeTokenExpiresFromPublicAccount < ActiveRecord::Migration
  def change
    change_column :public_accounts, :token_expires_at, :integer
  end
end
