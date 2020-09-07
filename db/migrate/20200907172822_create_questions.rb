class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :product, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.text :question_message

      t.timestamps
    end
  end
end
