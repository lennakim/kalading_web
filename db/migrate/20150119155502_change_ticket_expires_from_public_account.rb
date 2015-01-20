class ChangeTicketExpiresFromPublicAccount < ActiveRecord::Migration
  def change
    change_column :public_accounts, :ticket_expires_at, :integer
  end
end
