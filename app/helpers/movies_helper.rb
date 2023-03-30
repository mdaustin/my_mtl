module MoviesHelper
    def movie_details(movie)
        Tmdb::Movie.detail(movie.id)
    end

    def movie_poster(movie)
        "https://image.tmdb.org/t/p/w154#{movie.poster_path}"
    end

    def create_movie_from_tmdb_id(tmdb_id)
        # Fetch movie details from TMDB
        movie_details = Tmdb::Movie.detail(tmdb_id)
        # Create a new movie
        movie = Movie.new(
            tmdb_id: movie_details.id,
            title: movie_details.title,
            overview: movie_details.overview,
            poster_path: movie_details.poster_path,
            release_date: movie_details.release_date,
            runtime: movie_details.runtime
        )
        # Save the movie
        movie.save
        # Return the movie
        movie
    end
end
