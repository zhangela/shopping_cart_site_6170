class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        cart = current_cart

        #user.carts.build(cart)
        cart.user = user
        cart.save
        redirect_to root_url, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      if current_user && !current_user.is_seller && current_cart
        cart = current_cart
        if cart
          cart.destroy
        end
      end
      redirect_to root_url, :notice => "Logged out!"
    end
end
