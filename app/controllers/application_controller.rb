class ApplicationController < ActionController::Base
    include SessionsHelper


    private
        # Confirms a logged in user
        def logged_in_user
            unless logged_in?
                store_location
                flash[:danger] = "Please log in."
                redirect_to login_url, status: :see_other
            end
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
