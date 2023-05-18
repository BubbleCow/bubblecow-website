class Order < ApplicationRecord

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

  private

  # Create the order number
  def generate_order_number
    last_order_number = Order.order(:order_number).last&.order_number.to_i || 0
    self.order_number = (last_order_number + 1).to_s.rjust(6, '0')
  end

end
