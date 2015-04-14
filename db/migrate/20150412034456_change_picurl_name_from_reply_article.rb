class ChangePicurlNameFromReplyArticle < ActiveRecord::Migration
  def change
    rename_column :reply_articles, :picurl, :pic
  end
end
