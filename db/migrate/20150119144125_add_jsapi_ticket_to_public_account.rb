class AddJsapiTicketToPublicAccount < ActiveRecord::Migration
  def change
    add_column :public_accounts, :jsapi_ticket, :string
  end
end
