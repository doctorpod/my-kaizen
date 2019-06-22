class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :uid

      t.timestamps
    end

    add_index :profiles, :uid, unique: true

    add_column :cards, :profile_id, :integer
    add_index :cards, :profile_id

    add_column :period_summaries, :profile_id, :integer
    add_index :period_summaries, :profile_id
  end
end
