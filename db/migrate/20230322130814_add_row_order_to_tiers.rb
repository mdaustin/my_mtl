class AddRowOrderToTiers < ActiveRecord::Migration[7.0]
  def change
    add_column :tiers, :row_order, :integer
  end
end
