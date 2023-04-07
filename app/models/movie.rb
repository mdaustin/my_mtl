class Movie < ApplicationRecord
    has_many :tier_movies, dependent: :destroy
    has_many :tiers, through: :tier_movies

    validates :title, presence: true
    validates :overview, presence: true
    validates :release_date, presence: true
    validates :tmdb_id, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :runtime, presence: true, numericality: { only_integer: true, greater_than: 0 }

    # Returns the url for the movie's poster
    def poster_url(size = "w154")
        "https://image.tmdb.org/t/p/#{size}#{poster_path}"
    end       

    def self.search(params)
        if params[:query].present?
            movie_search = Tmdb::Search.movie(params[:query]).results

            if movie_search.present?
                movie_search.each do |movie|
                    begin
                    movie = Movie.find_or_create_by(tmdb_id: movie.id) do |m|
                        movie_with_details = Tmdb::Movie.detail(movie.id)
                        m.tmdb_id = movie_with_details.id
                        m.title = movie_with_details.title
                        m.overview = movie_with_details.overview
                        m.release_date = movie_with_details.release_date
                        m.runtime = movie_with_details.runtime
                        m.poster_path = movie_with_details.poster_path
                    end
                    rescue Tmdb::Error => e 
                        puts "Error fetching movie details for movie with TMDB ID #{movie.id}: #{e.message}"
                        next # continue to the next movie
                    end
                end
            else
                @movies = Movie.none
            end
        end
        @movies = Movie.all.where(tmdb_id: movie_search.map(&:id))
    end

    def self.create_from_tmdb_id(tmdb_id)
        movie = Tmdb::Movie.detail(tmdb_id)
        Movie.create(
             tmdb_id: movie.id,
             title: movie.title,
             overview: movie.overview,
             release_date: movie.release_date,
             runtime: movie.runtime,
             poster_path: movie.poster_path)
    end
end
