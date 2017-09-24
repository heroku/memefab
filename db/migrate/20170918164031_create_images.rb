class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :name, null: false, limit: 50
      t.index :name, unique: true

      t.string :upload_id, null: false
      t.index :upload_id, unique: true

      t.timestamps
    end
  end
end
