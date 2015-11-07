class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.json :data
      t.string :tag_id
      t.timestamp :creation_date

      t.timestamps null: false
    end
  end
end
