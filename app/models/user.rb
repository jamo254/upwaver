class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :avatar
  has_many :promos

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          # Creating validation for the user
  validates :full_name, presence: true, length: { maximum: 50 }

  
end
