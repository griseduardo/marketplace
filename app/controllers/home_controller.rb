class HomeController < ApplicationController
  def index
    @product_categories = ProductCategory.all.order(:name)
  end   
end