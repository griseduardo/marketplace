class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :full_name
      t.string :chosen_name
      t.date :birthday
      t.string :position
      t.string :sector
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
