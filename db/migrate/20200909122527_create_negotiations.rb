class CreateNegotiations < ActiveRecord::Migration[6.0]
  def change
    create_table :negotiations do |t|
      t.text :negotiation_message
      t.references :profile, null: false, foreign_key: true
      t.references :purchased_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
