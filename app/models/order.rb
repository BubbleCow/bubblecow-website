class Order < ApplicationRecord

    # Relationships
    belongs_to :book
    belongs_to :product
    belongs_to :editor, class_name: 'User', optional: true
  
    # Attachments
    has_one_attached :initial_unedited_manuscript
  
    # Validations
    validates :product_id, presence: true
    validates :initial_unedited_manuscript, presence: true, manuscript_content_type: true
  
    include AASM

    # AASM configuration for state machine
    aasm column: 'aasm_state' do
      state :submitted, initial: true
      state :rejected
      state :accepted
      state :invoice_sent
      state :invoice_paid
      state :editing_underway
      state :edit_returned

      # Define events for state transitions here
      # Example:
      event :reject do
        transitions from: :submitted, to: :rejected
      end

      event :accept do
        transitions from: :submitted, to: :accepted
      end

      event :send_invoice do
        transitions from: :accepted, to: :invoice_sent
      end

    end

end
