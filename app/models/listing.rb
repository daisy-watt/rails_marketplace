class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :listings_dietries, dependent: :destroy
  has_many :dietries, through: :listings_dietries
  has_one_attached :picture

  #validations for listings to be saved
  validates :title, :description, :price, presence: true
  validates :title, length: {minimum: 4}

  #sanitise data with lifecycle hooks
  before_save :remove_whitespace
  before_save :replace_word
  before_validation :convert_price_to_cents, if: :price_changed?

  private

  #removing whitespace 
  def remove_whitespace
    self.title = self.title.strip
    self.description =self.description.strip
  end

  #removing the word EXPENSIVE because this is an affordable community app!! no big $$$ items here
  def replace_word
    self.title = self.title.gsub(/expensive/i, "affordable")
    self.description = self.title.gsub(/expensive/i, "affordable")
  end

  def convert_price_to_cents
    self.price = (self.attributes_before_type_cast["price"].to_f * 100).round
  end


end
