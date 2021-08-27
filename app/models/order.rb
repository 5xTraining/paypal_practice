class Order < ApplicationRecord
  include AASM

  has_many :order_items

  after_create :order_num_generator

  aasm column: 'state' do
    state :pending, initial: true
    state :paid, :cancelled

    event :pay do
      transitions from: :pending, to: :paid
    end

    event :cancel do
      transitions from: [:pending, :paid], to: :cancelled
    end
  end

  private
  def paddingZero(num, digits)
    (("0" * digits) + num.to_s).last(digits)
  end

  def order_num_generator
    today = Time.now
    serial = today.strftime("%Y%m%d")

    self.serial = "OD#{serial}#{paddingZero(self.id, 6)}"
    self.save
  end
end
