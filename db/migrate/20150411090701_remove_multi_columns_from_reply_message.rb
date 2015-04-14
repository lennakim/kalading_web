class RemoveMultiColumnsFromReplyMessage < ActiveRecord::Migration
  def change
    remove_column :reply_messages, :article_count, :integer
    remove_column :reply_messages, :articles,      :text
    remove_column :reply_messages, :title,         :string
    remove_column :reply_messages, :description,   :text
    remove_column :reply_messages, :pic_url,       :string
    remove_column :reply_messages, :url,           :string
  end
end
