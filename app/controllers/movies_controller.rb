class MoviesController < ApplicationController
    def search 
        query = params[:query]
        if query.present?
            @movies = Tmdb::Search.movie(query).results
        else
            @movies = []
        end

        @user = User.find(params[:user_id])
        @tier_list = TierList.find(params[:tier_list_id])
        @tiers = @tier_list.tiers

        render 'tier_lists/show'
        # render user_tier_list_path(@user, @tier_list)
    end
end
