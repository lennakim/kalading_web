class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :to_user_name
      t.string :from_user_name
      t.string :create_time
      t.string :msg_type
      t.text :contnet
      t.string :msg_id
      t.string :pic_url
      t.string :media_id
      t.string :format
      t.string :thumb_media_id
      t.string :location_x
      t.string :location_y
      t.string :scale
      t.string :label
      t.string :title
      t.text :description
      t.string :url
      t.references :user, index: true

      t.timestamps
    end
  end
end
