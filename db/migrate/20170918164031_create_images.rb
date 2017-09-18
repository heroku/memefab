class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
      t.string :name
      t.string :remote_id

      t.timestamps
    end
  end
end
