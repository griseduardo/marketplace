class CreatePurchasedProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :purchased_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.integer :total_quantity
      t.date :start_date
      t.date :end_date
      t.float :final_value
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
