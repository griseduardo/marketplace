class HomeController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end   
end