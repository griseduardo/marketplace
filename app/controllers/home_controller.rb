class HomeController < ApplicationController

  def index
    if user_signed_in?
      @product_categories = ProductCategory.order(:name)
      @users = User.where(company: current_user.company)
      @profiles = Profile.where(user: @users)
      @products = Product.where(profile: @profiles)
    else
      @product_categories = ProductCategory.order(:name)  
    end
  end   
end