class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :listings_dietries, dependent: :destroy
  has_many :dietries, through: listings_dietries
  has_one_attached :picture
end
