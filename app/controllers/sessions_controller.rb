class SessionsController < ApplicationController
    before_action :require_login, only:[:destroy]
    def create
        @user = User.find_by_email(params[:email])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect_to "/shoes"
        else 
          flash[:errors] = ["Invalid Combination"]
          redirect_to "/"
        end
    end


    def destroy
        reset_session
        redirect_to "/"
      end
end
