class CreateMemes < ActiveRecord::Migration[5.1]
  def change
    create_table :memes, id: :uuid do |t|
      t.string :top, limit: 50
      t.string :bottom, limit: 50
      t.string :remote_id, null: false
      t.string :image_id, null:false

      t.timestamps

      t.index :image_id
    end
  end
end
