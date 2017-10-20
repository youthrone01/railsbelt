class ShoesController < ApplicationController
    before_action :require_login

    def index
        @all_shoes = Shoe.where(buyer:nil).order(id: :desc)
    end

    def create
        @shoes = Shoe.new(shoes_params)
        if @shoes.save
            redirect_to "/dashboard/#{current_user.id}"
        else
            flash[:errors] = @shoes.errors.full_messages
            redirect_to "/dashboard/#{current_user.id}"
        end
    end

    def update
        @shoes = Shoe.find(params[:id])
        @shoes.update(buyer:current_user, date: Time.now)
        @shoes.save
        redirect_to "/dashboard/#{current_user.id}" 
    end

    def destroy
        @shoes = Shoe.find(params[:id])
        @shoes.destroy
        redirect_to "/dashboard/#{current_user.id}"
    end

    private
    def shoes_params
        params.require(:shoes).permit(:name, :price).merge(user:current_user)
    end
end
