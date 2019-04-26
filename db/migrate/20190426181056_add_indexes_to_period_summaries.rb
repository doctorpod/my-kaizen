class AddIndexesToPeriodSummaries < ActiveRecord::Migration[5.2]
  def change
    add_index :period_summaries, [:item_id, :date], unique: true
    add_index :period_summaries, [:card_id, :date]
  end
end
