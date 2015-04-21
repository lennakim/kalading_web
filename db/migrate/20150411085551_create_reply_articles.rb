class CreateReplyArticles < ActiveRecord::Migration
  def change
    create_table :reply_articles do |t|
      t.string :article_count
      t.text :articles
      t.string :title
      t.string :description
      t.string :picurl
      t.string :url
      t.references :reply_message, index: true

      t.timestamps
    end
  end
end
