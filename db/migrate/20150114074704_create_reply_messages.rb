class CreateReplyMessages < ActiveRecord::Migration
  def change
    create_table :reply_messages do |t|
      t.string :to_user_name
      t.string :msg_type
      t.text :content
      t.string :media_id
      t.string :title
      t.text :description
      t.string :music_url
      t.string :hq_music_url
      t.string :thumb_media_id
      t.integer :article_count
      t.text :articles
      t.string :pic_url
      t.string :url
      t.integer :public_account_id
      t.string :name

      t.timestamps
    end
  end
end
