class DeleteChecks < ActiveRecord::Migration[5.2]
  def up
    drop_table :checks
  end

  def down
    create_table :checks do |t|
      t.string :comment
      t.integer :item_id

      t.timestamps
    end
  end
end
