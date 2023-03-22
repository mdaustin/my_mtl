class TiersController < ApplicationController
    before_action :set_tier, only: [:show, :edit, :update, :destroy]
    before_action :set_tier_list, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
    #before_action :correct_user, only: [:create, :edit, :update, :destroy]
    

    def index 
        @tiers = @tier_list.tiers
    end 

    def new 
        @tier = Tier.new
    end

    # Post /tier_lists/:tier_list_id/tiers
    def create 
        @tier = @tier_list.tiers.build(tier_params)
        respond_to do |format|
            if @tier.save
                format.turbo_stream do 
                    render turbo_stream: [
                        turbo_stream.update('new_tier', partial: 'tiers/form', locals: { tier: Tier.new })
                    ]
                end
                format.html { redirect_to user_tier_list_path(@current_user, @tier_list), notice: "Tier was successfully created." }
            else
                flash[:danger] = "A problem occured while creating your tier."
                format.turbo_stream do 
                    render turbo_stream: [
                        turbo_stream.update('new_tier', partial: 'tiers/form', locals: { tier: @tier })
                    ]
                end
                format.html { render 'new', status: :unprocessable_entity }
                format.json { render json: @tier.errors, status: :unprocessable_entity }
            end
        end
    end


    # Patch/Put /tier_lists/:tier_list_id/tiers/:id
    def update
        respond_to do |format|
            if @tier.update(tier_params)
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@tier) }
                format.html { redirect_to user_tier_list_path(@current_user, @tier_list) }
            else
                format.html { render :edit }
            end
        end
    end


    # Delete /tier_lists/:tier_list_id/tiers/:id
    def destroy
        @tier.destroy
        respond_to do |format|
            format.turbo_stream { render turbo_stream: turbo_stream.remove(@tier) }
            format.html { redirect_to user_tier_list_path(@current_user, @tier_list) }
        end
    end


    # Used to sort a tier
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
