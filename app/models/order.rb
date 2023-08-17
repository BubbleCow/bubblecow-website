class Order < ApplicationRecord
  include AASM

  # relationships
  belongs_to :user
  belongs_to :book
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # callbacks
  before_validation :generate_order_number, on: :create

  # relationships
  belongs_to :book
  belongs_to :user

  # Define state machine statuses as symbols
  enum status: { pending: 0, in_progress: 1, completed: 2, cancelled: 3 }

  # Define the AASM states and transitions
  aasm column: :status, enum: true do
    state :pending, initial: true
    state :in_progress
    state :completed
    state :cancelled

    event :start do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :cancel do
      transitions from: [:pending, :in_progress], to: :cancelled
    end
  end

  private

  # Create the order number
  def generate_order_number
    last_order_number = Order.order(:order_number).last&.order_number.to_i || 0
    self.order_number = (last_order_number + 1).to_s.rjust(6, '0')
  end

end
