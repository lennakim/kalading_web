class ChangeTicketExpiresAtFromPublicAccount < ActiveRecord::Migration
  def change
    change_column :public_accounts, :ticket_expires_at, :datetime
  end
end
