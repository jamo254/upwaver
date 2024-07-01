class CreatePromos < ActiveRecord::Migration[7.1]
  def change
    create_table :promos do |t|
      t.string :title
      t.string :video
      t.boolean :active, default: false
      t.boolean :has_single_pricing, default: false
      t.references :user, null: false, foreign_key: true
      # t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
