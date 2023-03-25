class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.integer :tmdb_id
      t.string :title
      t.text :overview
      t.date :release_date
      t.integer :runtime
      t.string :poster_path

      t.timestamps
    end
    add_index :movies, :tmdb_id, unique: true
  end
end
