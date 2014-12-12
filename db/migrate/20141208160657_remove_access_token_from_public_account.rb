class RemoveAccessTokenFromPublicAccount < ActiveRecord::Migration
  def change
    remove_column :public_accounts, :access_token, :string
  end
end
