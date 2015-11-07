class TagMedia < ActiveRecord::Migration
  def change
    create_table :tag_media, :id=> false do |t|
        t.integer :tag_feed_id
        t.integer :medium_id
    end
  end
end
