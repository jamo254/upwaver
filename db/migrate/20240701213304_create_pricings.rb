class CreatePricings < ActiveRecord::Migration[7.1]
  def change
    create_table :pricings do |t|
      t.string :title
      t.text :description
      t.integer :delivery_time
      t.integer :price
      t.integer :pricing_type
      t.references :promo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
