class AnswersController < ApplicationController   
  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      @question = Question.find_by(answer: @answer)
      @product = Product.find(@question.product_id) 
      redirect_to product_path(@product), notice: 'Resposta enviada com sucesso!'
    else
      @question = Question.find_by(answer: @answer)
      @product = Product.find(@question.product_id)
      redirect_to product_path(@product), notice: 'Faltou preencher pergunta ou pergunta já foi respondida!'
    end
  end 

  private
  def answer_params
    params.require(:answer).permit(:answer_message, :question_id)
  end
end