class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [ :index, :show, :new, :create, :edit, :update ]
  before_action :verify_product_owner, only: [ :edit ]

  def index
    @profile = Profile.find_by(user: current_user)
    @products = Product.where(profile: @profile)
  end

  def show
    @product = Product.find(params[:id])
    @questions = Question.where(product: @product)
    @answer = Answer.new
    @purchased_products = PurchasedProduct.where(product: @product).where(status: :in_progress) 
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

  def edit
    @product = Product.find(params[:id])
    @product_category = ProductCategory.all
    @product_subcategory = ProductSubcategory.all
    @product_condition = ProductCondition.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      if @product.quantity > 0
        @product.status = :available  
      elsif @product.quantity == 0
        @product.status = :unavailable
      end
      @product.update(product_params)
      redirect_to product_path(@product), notice: 'Editado com sucesso!'
    else
      @product_category = ProductCategory.all
      @product_subcategory = ProductSubcategory.all
      @product_condition = ProductCondition.all
      render :edit
    end
  end

  def suspend
    @product = Product.find(params[:id])
    @product.suspended!
    @product.save
    redirect_to product_path(@product)
  end

  def reactivate
    @product = Product.find(params[:id])
    if @product.quantity > 0
      @product.status = :available  
    elsif @product.quantity == 0
      @product.status = :unavailable
    end
    @product.save
    redirect_to product_path(@product)
  end

  private

  def product_params
    params.require(:product)
          .permit(:name, :status, :product_subcategory_id, :description, :price, 
                  :product_condition_id, :quantity, :profile_id, images:[])
  end

  def verify_product_owner
    unless current_user.profile == Product.find(params[:id]).profile
      redirect_to root_path, notice: 'Somente pode editar seu próprio produto!'
    end
  end
end