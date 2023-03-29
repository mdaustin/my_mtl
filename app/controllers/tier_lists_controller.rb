class TierListsController < ApplicationController
    before_action :logged_in_user, only: [:new, :update, :edit, :create, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    #before_action :get_user
    
    def index
        @tier_lists = @user.tier_lists
    end

    def show 
        @user = User.find(params[:user_id])
        @tier_list = TierList.find(params[:id])
        @tiers = @tier_list.tiers.rank(:row_order)
    end

    def new 
        @tier_list = TierList.new
    end

    def create
        @tier_list = @current_user.tier_lists.build(tier_list_params)

        if @tier_list.save 
            flash[:success] = "Tier List Created!"
            redirect_to @current_user
            #redirect_to user_tier_list_path(@user, @tier_list)
            #redirect_to user_tier_lists_path(@tier_list)
        else 
            flash[:danger] = "A problem occured while creating your tier list."
            render 'new', status: :unprocessable_entity
        end
    end

    def edit

    end 

    def update 
        if @tier_list.update(tier_list_params)
            flash[:success] = "Tier List successfully updated."
            redirect_to user_tier_lists_path(@tier_list)
        else 
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy 
        @tier_list.destroy
        flash[:notice] = "Tier_list was successfully deleted."
        redirect_to @current_user
    end
    private 
        # Defines tier list params 
        def tier_list_params
            params.require(:tier_list).permit(:title, :description)
        end
        
        # Verifies correct user by redirecting user is tier_list does not belong to the current user
        def correct_user
            @tier_list = current_user.tier_lists.find_by(id: params[:id])
            redirect_to current_user, status: :see_other if @tier_list.nil?
        end
                
        # Gets a user
        def get_user 
            @user = User.find(params[:user_id])
        end    
end