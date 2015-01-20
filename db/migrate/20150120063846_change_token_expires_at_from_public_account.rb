class ChangeTokenExpiresAtFromPublicAccount < ActiveRecord::Migration
  def change
    change_column :public_accounts, :token_expires_at, :datetime
  end
end
