class TiersController < ApplicationController
    before_action :set_tier, only: [:show, :edit, :update, :destroy]
    before_action :set_tier_list, only: [:index, :new, :create, :edit, :update, :destroy]

    def index 
        @tiers = @tier_list.tiers
    end 

    def new 

    end
    def create 
        @tier = @tier_list.tiers.build(tier_params)
        if @tier.save
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.append(:tiers, @tier) }
                format.html { redirect_to tier_list_path(@tier_list) }
            end
        else
            flash[:danger] = "Tier could not be created."
            redirect_to tier_list_path(@tier_list)
        end
    end

    # Patch/Put /tier_lists/:tier_list_id/tiers/:id
    def update
        respond_to do |format|
            if @tier.update(tier_params)
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@tier) }
                format.html { redirect_to tier_list_path(@tier_list) }
            else
                format.html { render :edit }
            end
        end
    end

    def sort 
        # debugger
        @tier = Tier.find(params[:id])
        @tier.update(row_order_position: params[:row_order_position])
        head :no_content
        # debugger
    end


    private 
        # Defines the tier params
        def tier_params
            params.require(:tier).permit(:title)
        end

        # Sets the tier
        def set_tier
            @tier = Tier.find(params[:id])
        end

        # Sets the tier list
        def set_tier_list
            @tier_list = TierList.find(params[:tier_list_id])
        end
end
