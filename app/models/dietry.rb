class Dietry < ApplicationRecord
    has_many :listings_dietries
    has_many :listings, through: :listings_dietries
end
