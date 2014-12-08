class AddAccessTokenToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :access_token, :string
  end
end
