class NegotiationsController < ApplicationController
  def create
    @purchased_product = PurchasedProduct.find(params[:purchased_product_id])
    @negotiation = @purchased_product.negotiations.new(negotiation_params)
    @product = @purchased_product.product
    @user = current_user
    @profile = Profile.find_by(user: @user)
    @negotiation.profile = @profile
    if @negotiation.save
      redirect_to product_purchased_product_path(@product, @purchased_product), notice: 'Mensagem enviada com sucesso!'
    else
      redirect_to product_purchased_product_path(@product, @purchased_product), notice: @negotiation.errors.full_messages.join(', ')
    end 
  end

  private
  def negotiation_params
    params.require(:negotiation).permit(:negotiation_message, :purchased_product_id, :profile_id)
  end
end