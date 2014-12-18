class RemoveLanguageFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :language, :string
  end
end
