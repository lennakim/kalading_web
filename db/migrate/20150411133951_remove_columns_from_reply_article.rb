class RemoveColumnsFromReplyArticle < ActiveRecord::Migration
  def change
    remove_column :reply_articles, :articles, :text
    remove_column :reply_articles, :article_count, :string
  end
end
