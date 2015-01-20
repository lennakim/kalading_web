class AddTicketExpiresAtToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :ticket_expires_at, :datetime
  end
end
