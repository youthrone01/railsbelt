class UsersController < ApplicationController
    before_action :require_login, only:[:show]
    before_action :require_correct_user, only:[:show]
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to "/shoes"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to "/"
        end

    end

    def show
        @user = User.find(params[:id])
        @not_sold_shoes = @user.shoes.where(buyer:nil).order(id: :desc)
        @sold_shoes = @user.shoes.where.not(buyer:nil).order(date: :desc)
        @total_sales = @user.shoes.where.not(buyer:nil).sum(:price)
        
        @purchased_shoes = Shoe.where(buyer: current_user).order(date: :desc)
        @total_purchases = Shoe.where(buyer: current_user).sum(:price)    
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email,:password, :password_confirmation)
    end


    def require_correct_user
        if User.exists?(params[:id])
            if current_user != User.find(params[:id])
                redirect_to "/dashboard/#{session[:user_id]}"
            end            
        else
            redirect_to "/dashboard/#{session[:user_id]}"
        end
    end
end
