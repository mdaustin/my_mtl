class TierMoviesController < ApplicationController

    def new 
        @tier_movie = TierMovie.new
    end

    def create
        @tier = Tier.find(params[:tier_id])
        @tier_movie = @tier.tier_movies.create(tier_movie_params)
        redirect_to user_tier_list_path(@tier.tier_list)
    end

    def destroy
        @tier = Tier.find(params[:tier_id])
        @tier_movie = @tier.tier_movies.find(params[:id])
        @tier_movie.destroy
        redirect_to user_tier_list_path(@tier.tier_list)
    end

    def sort
        @tier_movie = TierMovie.find(params[:id])
        @tier = Tier.find(params[:new_tier_id])
        @tier_movie.update(row_order_position: params[:row_order_position], tier: @tier)
        head :no_content
    end


    private
        # Only allow a list of trusted parameters through.
        def tier_movie_params
            params.require(:tier_movie).permit(:movie_id, :tier_id, :row_order_position)
        end

        # Use callbacks to share common setup or constraints between actions.
        def set_tier_movie
            @tier_movie = TierMovie.find(params[:id])
        end
end
