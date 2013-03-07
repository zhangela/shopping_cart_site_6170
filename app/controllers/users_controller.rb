class UsersController < ApplicationController
    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = user.id
        cart = current_cart
        cart.user = @user
        cart.save
        redirect_to root_url, :notice => "Signed up!"
      else
        render :new
      end
    end

    def new_cart

    end
end
