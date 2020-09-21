class PurchasedProductsController < ApplicationController
  before_action :authenticate_user!, only: [ :show, :new, :create, :sell, :buy, :refuse ]

  def show
    @product = Product.find(params[:product_id])
    @purchased_product = PurchasedProduct.find(params[:id])
  end

  def create
    if current_user.profile.blank?
      redirect_to new_profile_path, notice: 'Necessário cadastrar perfil!'
    else
      @product = Product.find(params[:product_id])
      @purchased_product = @product.purchased_products.new(purchased_product_params)
      @user = current_user
      @profile = Profile.find_by(user: @user)
      @purchased_product.profile = @profile
      @purchased_product.start_date = Date.current
      if @purchased_product.total_quantity.present?
        @purchased_product.initial_price
      end
      if @purchased_product.save
        @product.quantity = @product.quantity - @purchased_product.total_quantity
        if @product.quantity > 0
          @product.status = :available  
        elsif @product.quantity == 0
          @product.status = :unavailable
        end
        @product.save
        redirect_to product_purchased_product_path(@product, @purchased_product), notice: "Compra iniciada!"
      else
        redirect_to product_path(@product), notice: @purchased_product.errors.full_messages.join(', ')
      end
    end
  end

  def sell
    @user = current_user
    @profile = Profile.find_by(user: @user)
    @products = Product.where(profile: @profile)
    @purchased_products = PurchasedProduct.where(product: @products)
  end

  def buy
    @user = current_user
    @profile = Profile.find_by(user: @user)
    @purchased_products = PurchasedProduct.where(profile: @profile)
  end

  def refuse
    @product = Product.find(params[:product_id])
    @purchased_product = PurchasedProduct.find(params[:id])
    @purchased_product.refused!
    @purchased_product.end_date = Date.current
    @purchased_product.save
    @product.quantity = @product.quantity + @purchased_product.total_quantity
    if @product.quantity > 0
      @product.status = :available
    elsif @product.quantity == 0
      @product.status = :unavailable
    end
    @product.save
    redirect_to product_purchased_product_path(@product, @purchased_product)
  end

  def confirm
    @product = Product.find(params[:product_id])
    @purchased_product = PurchasedProduct.find(params[:id])
    @purchased_product.in_progress!
    @purchased_product.save
    redirect_to product_purchased_product_path(@product, @purchased_product)
  end

  def cancel
    @product = Product.find(params[:product_id])
    @purchased_product = PurchasedProduct.find(params[:id])
    @purchased_product.canceled!
    @purchased_product.end_date = Date.current
    @purchased_product.save
    @product.quantity = @product.quantity + @purchased_product.total_quantity
    if @product.quantity > 0
      @product.status = :available  
    elsif @product.quantity == 0
      @product.status = :unavailable
    end
    @product.save
    redirect_to product_purchased_product_path(@product, @purchased_product)  
  end

  def conclude
    @product = Product.find(params[:product_id])
    @purchased_product = PurchasedProduct.find(params[:id])
    @purchased_product.update(purchased_product_params)
    @purchased_product.end_date = Date.current
    @purchased_product.calculate_value
    if @purchased_product.save
      @purchased_product.finished!
      redirect_to product_purchased_product_path(@product, @purchased_product)
    else
      render :show
    end
  end

  private
  def purchased_product_params
    params.require(:purchased_product)
          .permit(:product_id, :profile_id, :total_quantity, :start_date, 
                  :end_date, :final_value, :status, :freight_cost, :discount)
  end
end