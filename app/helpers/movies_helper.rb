module MoviesHelper
    def movie_details(movie)
        Tmdb::Movie.detail(movie.id)
    end

    def movie_poster(movie)
        "https://image.tmdb.org/t/p/w154#{movie.poster_path}"
    end
end
