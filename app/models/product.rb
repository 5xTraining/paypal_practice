class Product < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  validates :price, numericality: true
end
