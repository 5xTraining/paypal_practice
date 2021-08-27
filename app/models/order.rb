class Order < ApplicationRecord
  include AASM

  has_many :order_items

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
end
