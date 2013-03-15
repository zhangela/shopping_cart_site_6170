class CartsController < ApplicationController

  # GET /carts/1
  # GET /carts/1.json
  def show

    if params[:cart_id]
      @cart = Cart.find(params[:cart_id])
    else
      @cart = current_cart
    end

    # if the user is unregistered or a seller or owns the cart
    if current_cart == @cart || (current_user && current_user.is_seller) || (current_user && @cart.user == current_user)

      if !@cart.is_empty
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @cart }
        end
      else
        respond_to do |format|
          format.html { redirect_to items_url }
          format.json { head :no_content }
        end
      end
    else
      render :text => "You do not have permission to view this cart."
    end

  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { head :no_content }
    end
  end


  def submit_cart
    cart = current_cart
    cart.submit

    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { head :no_content }
    end
  end


  def approve_cart
    cart = Cart.find(params[:cart_id])
    cart.approve

    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { head :no_content }
    end
  end

  def deny_cart
    cart = Cart.find(params[:cart_id])
    cart.deny

    respond_to do |format|
      format.html { redirect_to items_path }
      format.json { head :no_content }
    end
  end

end
