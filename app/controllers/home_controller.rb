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
  
  def search
    @product_categories = ProductCategory.order(:name)
    @users = User.where(company: current_user.company)
    @profiles = Profile.where(user: @users)
    @product_subcategories = ProductSubcategory.where('name LIKE ?', "%#{params[:q]}%")
    @products = Product.where(profile: @profiles).where('name LIKE ?', "%#{params[:q]}%")
                .or(Product.where(profile: @profiles, product_subcategory: @product_subcategories))
                .or(Product.where(profile: @profiles).where('description LIKE ?', "%#{params[:q]}%"))
    render :index
  end
end