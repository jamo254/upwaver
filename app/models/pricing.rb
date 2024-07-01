class Pricing < ApplicationRecord
  belongs_to :promo
  enum pricing_type: [:basic, :standard, :golden]
end
