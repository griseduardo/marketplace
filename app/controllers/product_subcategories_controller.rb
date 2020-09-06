class ProductSubcategoriesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]

  def show
    @product_subcategory = ProductSubcategory.find(params[:id])
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @products = Product.where(profile: @profiles, product_subcategory: @product_subcategory)  
  end

  def search
    @product_subcategory = ProductSubcategory.find(params[:id])
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @products = Product.where(profile: @profiles, product_subcategory: @product_subcategory).where('name LIKE ?', "%#{params[:q]}%")
                .or(Product.where(profile: @profiles, product_subcategory: @product_subcategory).where('description LIKE ?', "%#{params[:q]}%"))
    render :show
  end
end