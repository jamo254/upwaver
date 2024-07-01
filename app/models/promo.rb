class Promo < ApplicationRecord
  belongs_to :user
   belongs_to :category

  has_many :pricings
  has_many_attached :photos
  has_rich_text :description

  #creates connection through the parent
  accepts_nested_attributes_for :pricings

  validates :title, presence: {message: 'cannot be blank'}

end
