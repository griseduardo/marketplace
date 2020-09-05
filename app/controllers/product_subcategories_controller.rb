class ProductSubcategoriesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]

  def show
    @product_subcategory = ProductSubcategory.find(params[:id])
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @products = Product.where(profile: @profiles, product_subcategory: @product_subcategory)  
  end
end