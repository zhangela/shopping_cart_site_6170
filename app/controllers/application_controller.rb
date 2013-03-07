class ApplicationController < ActionController::Base

    protect_from_forgery
    helper_method :current_user
    helper_method :current_cart
    before_filter :add_value_to_session

    # This can be toggled to inspect the session hash.
    # Run curl -I localhost:3000 (default)
    #     ruby decode.rb BAh7CEkiD3Nl%3D--eef6f421eb6e51fa8b269b2fd9b406f8f5a3f265 (this will be way longer)
    # This will decode the cookies and note that decode.rb is in the root dir of this app.
    private

    def add_value_to_session
        session[:message] = "Hello World!"
    end

    private
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    private
    def current_cart 
      cart = Cart.find(session[:cart_id])
      rescue ActiveRecord::RecordNotFound
        cart = Cart.create
        cart.user = current_user
        session[:cart_id] = cart.id
        cart.save

      return cart
    end

end
