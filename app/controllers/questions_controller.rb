class QuestionsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @question = @product.questions.new(question_params)
    @user = User.find_by(email: current_user.email)
    @profile = Profile.find_by(user: @user)
    @question.profile = @profile
    if @question.save   
      redirect_to product_path(@product), notice: 'Pergunta enviada com sucesso!'
    else
      redirect_to product_path(@product), notice: 'Faltou preencher pergunta'
    end
  end
  
  private
    def question_params
      params.require(:question).permit(:question_message, :product_id)
    end
end