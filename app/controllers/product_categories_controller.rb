class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  
  def show
    @product_category = ProductCategory.find(params[:id])
    @product_subcategories = ProductSubcategory.where(product_category: @product_category)
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @products = Product.where(profile: @profiles, product_subcategory: @product_subcategories)
  end
  
  def search
    @product_category = ProductCategory.find(params[:id])
    @product_subcategories = ProductSubcategory.where(product_category: @product_category)
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @products = Product.where(profile: @profiles, product_subcategory: @product_subcategories).where('name LIKE ?', "%#{params[:q]}%")
                .or(Product.where(profile: @profiles, product_subcategory: @product_subcategories).where('description LIKE ?', "%#{params[:q]}%"))
    render :show
  end
end