class TiersController < ApplicationController
    before_action :set_tier, only: [:show, :edit, :update, :destroy]
    before_action :set_tier_list, only: [:index, :new, :create, :edit, :update, :destroy]
    before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :create, :update, :destroy]
    

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
                        # Turbo Stream to update the tier form
                        turbo_stream.update('new_tier', partial: 'tiers/form', locals: { tier: Tier.new }),
                        # Turbo Stream to update the tier list
                        turbo_stream.append('tiers', partial: 'tiers/tier', locals: { tier: @tier })
                    ]
                end
                format.html { redirect_to user_tier_list_path(@current_user, @tier_list), notice: "Tier was successfully created." }
            else
                flash[:danger] = "A problem occured while creating your tier."
                # Turbo Stream to update the tier form errors
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
        debugger
        @tier.destroy
        
        redirect_to user_tier_list_path(@current_user, @tier_list), notice: "Tier was successfully deleted."
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

        # Verifies correct user by redirecting user 
        def correct_user
            @tier_list = current_user.tier_lists.find_by(id: params[:tier_list_id])
            redirect_to current_user, status: :see_other if @tier_list.nil?
        end
end
