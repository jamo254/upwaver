class AddReferenceToPromos < ActiveRecord::Migration[7.1]
  def change
    add_reference :promos, :category, null: false, foreign_key: true
  end
end
