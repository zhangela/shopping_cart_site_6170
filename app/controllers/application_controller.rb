class ApplicationController < ActionController::Base

    protect_from_forgery
    helper_method :current_user
    helper_method :current_cart
    helper_method :all_submitted_carts
    helper_method :all_approved_carts
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
      if session[:user_id] && User.exists?(session[:user_id])
        @current_user ||= User.find(session[:user_id])
      end
    end

    private
    #def current_cart
    #  cart = Cart.find(session[:cart_id])
    #  puts "CART IS FOUND"
    #  rescue ActiveRecord::RecordNotFound
    #    puts "CART IS NOT FOUND"
    #    cart = Cart.create
    #    cart.user = current_user
    #    cart.status = 0
    #    session[:cart_id] = cart.id
    #    cart.save
    #
    #  if cart.status != 0
    #    puts "CART STATUS IS NOT 0"
    #    cart = Cart.create
    #    cart.user = current_user
    #    session[:cart_id] = cart.id
    #    cart.save
    #  end
    #  return cart
    #end


    def current_cart
      exist = Cart.exists?(session[:cart_id])
      puts "EXISTS?"
      puts exist
      if exist
        cart = Cart.find(session[:cart_id])
        if cart.status == 0
          puts "STATUS = 0"
          return cart
        end
      end

      puts "CREATING CART"
      cart = Cart.create(:status => 0)
      cart.user = current_user
      session[:cart_id] = cart.id
      cart.save
      return cart

    end

    private
    def all_submitted_carts
      carts = Cart.find_all_by_status(1)
      return carts
    end

    private
    def all_approved_carts
      carts = Cart.find_all_by_status(2)
      return carts
    end

end
