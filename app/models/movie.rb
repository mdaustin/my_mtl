class Movie < ApplicationRecord
    has_many :tier_movies, dependent: :destroy
    has_many :tiers, through: :tier_movies

    validates :title, presence: true
    validates :overview, presence: true
    validates :release_date, presence: true
    validates :tmdb_id, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :runtime, presence: true, numericality: { only_integer: true, greater_than: 0 }

    # Returns the url for the movie's poster
    def poster_url
        "https://image.tmdb.org/t/p/w92#{poster_path}"
    end       
end
