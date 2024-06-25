class Order < ApplicationRecord

    # Relationships
    belongs_to :book
    belongs_to :product
    belongs_to :editor, class_name: 'User', optional: true
  
    # Attachments
    has_one_attached :initial_unedited_manuscript
    has_one_attached :edited_manuscript_for_paid_developmental_edit
    has_one_attached :editors_report_for_paid_developmental_edit
  
    # Validations
    validates :initial_unedited_manuscript, presence: true, manuscript_content_type: true
    validates :edited_manuscript_for_paid_developmental_edit, manuscript_content_type: true
  
    # Sets the inactive and active state
    def inactive?
      aasm_state.in?(["product_rejected", "product_invoice_unpaid", "product_files_returned"])
    end
  
    # Scopes
    scope :active, -> { where.not(aasm_state: ["product_rejected", "product_invoice_unpaid", "product_files_returned"]) }
    
    # State machine 
    include AASM 
  
    aasm do
      state :new, initial: true
      state :product_submitted, :product_accepted, :product_rejected, :product_invoice_sent, :product_invoice_paid, :product_invoice_unpaid, :product_editor_assigned, :product_files_returned
  
      event :submit do
        transitions from: :new, to: :product_submitted, after: :trigger_actions_after_submit
      end
  
      event :accept do
        transitions from: [:new, :product_submitted], to: :product_accepted, after: :trigger_actions_after_acceptance
      end
  
      event :reject do
        transitions from: [:new, :product_submitted], to: :product_rejected, after: :trigger_actions_after_rejection
      end
  
      event :invoice_sent do
        transitions from: :product_accepted, to: :product_invoice_sent, after: :trigger_actions_after_invoice_sent
      end
  
      event :invoice_paid do
        transitions from: :product_invoice_sent, to: :product_invoice_paid, after: :trigger_actions_after_invoice_paid
      end
  
      event :invoice_unpaid do
        transitions from: :product_invoice_sent, to: :product_invoice_unpaid, after: :trigger_actions_after_invoice_unpaid
      end
  
      event :assign_editor do
        transitions from: :product_invoice_paid, to: :product_editor_assigned, after: :trigger_actions_after_editor_assigned
      end
  
      event :return_files do
        transitions from: :product_editor_assigned, to: :product_files_returned, after: :trigger_actions_after_files_returned
      end  
  
    end
  
    after_create :submit_product
    before_update :assign_editor, if: :editor_id_changed?
    before_update :return_files, if: :editorial_files_uploaded?
  
    def submit_product
      submit!
    end
  
    def assign_editor
      assign_editor! if self.aasm_state == 'product_invoice_paid' && self.editor_id.present?
    end
  
    def editorial_files_uploaded?
      edited_manuscript_for_paid_developmental_edit.attached? && editors_report_for_paid_developmental_edit.attached? && aasm_state == 'product_editor_assigned'
    end
  
    def return_files
      return_files! if may_return_files?
    end  
  
    private
  
    def trigger_actions_after_submit
      # UserMailer.product_submission_email(self.user).deliver_later

    end
  
    def trigger_actions_after_acceptance
      # Define any actions to be performed after acceptance here
    end
  
    def trigger_actions_after_rejection
      # Define any actions to be performed after rejection here
    end
  
    def trigger_actions_after_invoice_sent
      # Define any actions to be performed after invoice sent here
    end
  
    def trigger_actions_after_invoice_paid
      # Define any actions to be performed after invoice is paid here
    end
  
    def trigger_actions_after_invoice_unpaid
      # Define any actions to be performed after invoice is unpaid here
    end
  
    def trigger_actions_after_editor_assigned
      # Define any actions to be performed after editor is assigned here
    end
  
    def trigger_actions_after_files_returned
      # Define any actions to be performed after files are returned here
    end
  
end
