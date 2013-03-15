class CartitemsController < ApplicationController

  def index
    @cartitems = Cartitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cartitems }
    end
  end

  def show
    @cartitem = Cartitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cartitem }
    end
  end

  # creates new cart item and insert into current cart
  def new

    @cart = current_cart

    if params[:cartitem]
      # ActiveResource
      @cartitem = Cartitem.new(params[:cartitem])
    else
      # HTML forms
      itemID = params[:item_id]
      @cartitem = @cart.add_item(itemID)


      respond_to do |format|
        format.html { redirect_to cart_path }
        format.json { head :no_content }
      end
    end

  end

  # GET /cartitems/1/edit
  def edit
    @cartitem = Cartitem.find(params[:id])
  end

  # POST /cartitems
  # POST /cartitems.json
  def create
    @cartitem = Cartitem.new(params[:cartitem])

    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { head :no_content }
    end
  end

  # PUT /cartitems/1
  # PUT /cartitems/1.json
  def update
    @cartitem = Cartitem.find(params[:id])

    respond_to do |format|
      if @cartitem.update_attributes(params[:cartitem])
        format.html { redirect_to cart_path }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cartitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cartitems/1
  # DELETE /cartitems/1.json
  def destroy
    @cartitem = Cartitem.find(params[:id])
    @cartitem.destroy

    respond_to do |format|
      format.html { redirect_to cart_path }
      format.json { head :no_content }
    end
  end
end
