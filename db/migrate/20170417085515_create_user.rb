class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :messenger_id
      t.string :gender
      t.timestamps
    end
  end
end