class AddAnswerMessageToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :answer_message, :text
  end
end
