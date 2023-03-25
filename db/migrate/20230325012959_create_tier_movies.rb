class CreateTierMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :tier_movies do |t|
      t.references :tier, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tier_movies, [:tier_id, :movie_id], unique: true
  end
end