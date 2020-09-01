class AddWorkAddressToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :work_address, :string
  end
end
