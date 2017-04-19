class AddCtaToAnswerTable < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :cta, :boolean
  end
end
