module SessionsHelper
    # Logs in the given user
    def log_in(user)
        session[:user_id] = user.id
        # Guard against session replay attacks
        #session[:session_token] = user.session_token
    end

    # Returns the current user
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    # Returns true if the user is logged in
    def logged_in? 
        !current_user.nil?
    end
end
