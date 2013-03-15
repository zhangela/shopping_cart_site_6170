class ApplicationController < ActionController::Base

    protect_from_forgery
    helper_method :current_user, :current_cart
    helper_method :all_submitted_carts, :all_approved_carts, :all_denied_carts
    before_filter :add_value_to_session

    private

    def add_value_to_session
        session[:message] = "Hello World!"
    end

    private
    def current_user
      if session[:user_id] && User.exists?(session[:user_id])
        @current_user ||= User.find(session[:user_id])
      end
    end

    private
    def current_cart
      exist = Cart.exists?(session[:cart_id])
      if exist
        cart = Cart.find(session[:cart_id])
        if cart.status == 0 # 0 = unsubmitted cart
          return cart
        end
      end
      cart = Cart.create(:status => 0)  # 0 = unsubmitted cart
      cart.user = current_user
      session[:cart_id] = cart.id
      cart.save
      return cart

    end

    private
    def all_submitted_carts
      carts = Cart.find_all_by_status(1) # 1 = submitted, but not approved cart
      return carts
    end

    private
    def all_approved_carts
      carts = Cart.find_all_by_status(2) # 2 = approved cart
      return carts
    end

    private
    def all_denied_carts
      carts = Cart.find_all_by_status(-1)
      return carts
    end

end
