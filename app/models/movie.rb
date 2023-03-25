class Movie < ApplicationRecord
    
    validates :title, presence: true
    validates :overview, presence: true
    validates :release_date, presence: true
    validates :tmdb_id, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :runtime, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
