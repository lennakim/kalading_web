class AddTimestampToAuthinfo < ActiveRecord::Migration
  def change
    add_column(:auth_infos, :created_at, :datetime)
    add_column(:auth_infos, :updated_at, :datetime)
  end
end
