class AddImpressionsCountToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :impressions_count, :integer, default: 0
  end
end
