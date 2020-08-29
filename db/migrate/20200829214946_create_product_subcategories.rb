class CreateProductSubcategories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_subcategories do |t|
      t.string :name
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
