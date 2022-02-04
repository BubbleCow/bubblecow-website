class DevEdit < ApplicationRecord
    include AASM

    # Callbacks
    before_save :check_state, if: :will_save_change_to_aasm_state?

    # Relationships
    belongs_to :book
    belongs_to :user, optional: true
 
    # Active Storage
    has_one_attached :unedited_manuscript
    has_one_attached :editors_report
    has_one_attached :edited_manuscript
 
    # Validations
    validates :unedited_manuscript, presence: true, content_type: { in: [:rtf, :docx, :doc, :odt], message: 'must be one of the following file formats: rtf, docx, doc, odt. Please try another file type or contact us directly.' }
 
    # Scopes
    default_scope { order(status_value: :asc) }
    scope :sorted_by_status, -> { order(status_value: :desc) }
    scope :sorted_by_date, -> { order(created_at: :asc) }
    scope :submitted, -> {sorted_by_date.where(status: "developmental_edit_created")}
    scope :rejected, -> {sorted_by_date.where(status: "developmental_edit_rejected")}
    scope :live_edits, -> {sorted_by_status.where.not(status: "developmental_edit_rejected")}

    # Sets stats for sample developmental edititng process 
    aasm do
        state :developmental_edit_created, initial: true
        state :developmental_edit_accepted
        state :developmental_edit_invoice_sent
        state :developmental_edit_invoice_paid
        state :developmental_edit_editing_underway
        state :developmental_edit_returned
        state :developmental_edit_rejected
    end

    private 

    # This is triggered on state change all logic and actions resulting from a state chnage should be placed here. 
    def check_state
      case aasm_state 

        when "developmental_edit_created"

            # add status value
            self.status_value = "1"

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Submitted")

        when "developmental_edit_accepted"

            # add status value
            self.status_value = "2"

            # add date of accetptance
            self.accepted_date = Time.now

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Accepted")
        
        when "developmental_edit_invoice_sent"

            # add status value
            self.status_value = "3"

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Invoice Sent")

        when "developmental_edit_invoice_paid"

            # add status value
            self.status_value = "4"

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Invoice Paid")

        when "developmental_edit_editing_underway"

            # add status value
            self.status_value = "5"

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Editing Underway")

        when "developmental_edit_returned"

            # add status value
            self.status_value = "6"
            
            #  Add return date
            self.return_date = Time.now

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Edit returned")

        when "developmental_edit_rejected"

            # add status value
            self.status_value = "7"
                
            self.rejected_date = Time.now

            # Update tag on active campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Developmental Editing - Rejected")

        end

    end
     
end
