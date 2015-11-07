class CreateTagFeeds < ActiveRecord::Migration
  def change
    create_table :tag_feeds do |t|
      t.string :hashtag
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :initial_tag_id
      t.string :latest_tag_id
      t.boolean :is_complete

      t.timestamps null: false
    end
  end
end
