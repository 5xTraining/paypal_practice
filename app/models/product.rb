class Product < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  validates :price, numericality: true

  def cover_src
    "#{cover}?ranom=#{id}"
  end
end
