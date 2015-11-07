class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :data
      t.string :json
      t.string :tagID
      t.string :integer
      t.string :creationDate
      t.string :timestamp

      t.timestamps null: false
    end
  end
end
