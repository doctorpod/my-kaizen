class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :description
      t.integer :goal
      t.integer :goal_period

      t.timestamps
    end
  end
end
