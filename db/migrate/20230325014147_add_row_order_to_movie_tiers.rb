class AddRowOrderToMovieTiers < ActiveRecord::Migration[7.0]
  def change
    add_column :tier_movies, :row_order, :integer
  end
end
