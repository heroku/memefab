class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :name, null: false
      t.index :name, unique: true

      t.string :remote_id, null: false
      t.index :remote_id, unique: true

      t.timestamps
    end
  end
end
