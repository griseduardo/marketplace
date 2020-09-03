class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.references :product_subcategory, null: false, foreign_key: true
      t.text :description
      t.float :price
      t.references :product_condition, null: false, foreign_key: true
      t.integer :quantity
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
