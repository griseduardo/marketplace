class AddValueAttributesToPurchasedProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :purchased_products, :initial_value, :float
    add_column :purchased_products, :freight_cost, :float
    add_column :purchased_products, :discount, :float
  end
end
