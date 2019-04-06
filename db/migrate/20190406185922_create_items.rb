class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.integer :min
      t.integer :max
      t.integer :period
      t.float :score, default: 1.0
      t.integer :card_id

      t.timestamps
    end
  end
end
