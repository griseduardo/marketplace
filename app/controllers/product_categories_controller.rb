class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  
  def show
    @product_category = ProductCategory.find(params[:id])
  end  
end