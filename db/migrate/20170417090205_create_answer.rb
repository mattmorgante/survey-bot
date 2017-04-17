class CreateAnswer < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
	  t.references :user, foreign_key: true
      t.string :meat_per_week
      t.string :dairy_per_week
      t.boolean :organic
      t.boolean :local
      t.boolean :status
    end
  end
end
