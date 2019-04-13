class CreatePeriodSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :period_summaries do |t|
      t.date :date
      t.integer :year
      t.integer :month
      t.integer :week
      t.integer :count
      t.float :score
      t.integer :item_id
      t.integer :card_id

      t.timestamps
    end
  end
end
