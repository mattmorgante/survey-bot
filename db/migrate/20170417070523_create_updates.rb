class CreateUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :updates do |t|
      t.integer :user_id
      t.integer :mood
      t.text :message

      t.timestamps
    end
  end
end