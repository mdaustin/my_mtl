class CreateTiers < ActiveRecord::Migration[7.0]
  def change
    create_table :tiers do |t|
      t.references :tier_list, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
