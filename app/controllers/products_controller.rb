class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def show
    @product = Product.find(params[:id])
  end

  def new
    if current_user.profile.blank?
      redirect_to new_profile_path, notice: 'Necessário cadastrar perfil!'
    else
      @product = Product.new
      @product_category = ProductCategory.all
      @product_subcategory = ProductSubcategory.all
      @product_condition = ProductCondition.all
    end
  end

  def create
    @product = Product.new(product_params)
    @user = User.find_by(email: current_user.email)
    @profile = Profile.find_by(user: @user)
    @product.profile = @profile
    if @product.save
      redirect_to @product, notice: 'Cadastrado com sucesso!'
    else
      @product_category = ProductCategory.all
      @product_subcategory = ProductSubcategory.all
      @product_condition = ProductCondition.all
      render :new
    end
  end

  private

  def product_params
    params.require(:product)
          .permit(:name, :product_subcategory_id, :description, :price, 
                  :product_condition_id, :quantity, :profile_id)
  end
end