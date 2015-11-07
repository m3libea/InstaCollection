class CreateTagFeeds < ActiveRecord::Migration
  def change
    create_table :tag_feeds do |t|
      t.string :hashtag
      t.timestamp :startDate
      t.timestamp :endDate
      t.integer :initialTagID
      t.integer :latestTagID
      t.boolean :isComplete

      t.timestamps null: false
    end
  end
end
