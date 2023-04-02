class MoviesController < ApplicationController
    def search 

        query = params[:query]
        if query.present?
            # Creates movie objects if they don't exist
            @movies = Movie.search(params)
            # Does not create movie objects if they don't exist
            # @movies = Tmdb::Search.movie(query).results
        else
            @movies = []
        end

        @user = User.find(params[:user_id])
        @tier_list = TierList.find(params[:tier_list_id])
        @tiers = @tier_list.tiers
        @search_results_tier = @tier_list.search_results_tier

        # Clear out the search results tier
        @search_results_tier.tier_movies.destroy_all

        @movies.each do |movie|
            @search_results_tier.tier_movies.create(movie: movie)
        end

        render 'tier_lists/show'
        # render user_tier_list_path(@user, @tier_list)
    end
end
