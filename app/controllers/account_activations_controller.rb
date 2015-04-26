class AccountActivationsController < ApplicationController

    def edit(user)
        @user = user
        if !@user.activated? && user && @user.authenticated(:activation,params[:id])
            @user.activate
            log_in user
            flash[:success] = "Successfully Activated! Please Login"
            redirect_to user
        else
            flash[:danger] = "Activation Link is invalid"
            redirect_to root_url
        end
    end

end
