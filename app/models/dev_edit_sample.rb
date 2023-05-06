class DevEditSample < ApplicationRecord
    include AASM

    # Callbacks
    before_save :check_state, if: :will_save_change_to_aasm_state?
    
    # Relationships
    belongs_to :book
    belongs_to :user, optional: true
 
    # Active storage
    has_one_attached :unedited_manuscript
    has_one_attached :editors_report
    has_one_attached :edited_manuscript
 
    # Validations
    validates :unedited_manuscript, presence: true, content_type: { in: [:rtf, :docx, :doc, :odt], message: 'must be one of the following file formats: rtf, docx, doc, odt. Please try another file type or contact us directly.' }
 
    # Scopes
    default_scope { order(status_value: :asc) }
 
    # Sets stats for sample developmental edititng process 
    aasm do
        state :sample_developmental_edit_created, initial: true
        state :sample_developmental_edit_accepted
        state :sample_developmental_edit_rejected
        state :sample_developmental_edit_editing_underway
        state :sample_developmental_edit_returned
    end
  
    
    private 

    # This is triggered on state change all logic and actions resulting from a state chnage should be placed here. 
    def check_state
      case aasm_state 

        when "sample_developmental_edit_created"

            # add status value
            self.status_value = "1"

            # Update tag on active campaign
            # ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Sample Developmental Editing - Submitted")

        when "sample_developmental_edit_accepted"

            # add status value
            self.status_value = "2"

            # add date of acceptance
            self.accepted_date = Time.now
            
            # Update tag on active campaign
            # ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Sample Developmental Editing - Accepted")
        
        when "sample_developmental_edit_editing_underway"

            # add status value
            self.status_value = "3"

            # Update tag on active campaign
            # ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Sample Developmental Editing - Returned")

        when "sample_developmental_edit_returned"

            # add status value
            self.status_value = "4"

            # add status value and add date of return
            self.return_date = Time.now

            # Update tag on active campaign
            # ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Sample Developmental Editing - Accepted")

        when "sample_developmental_edit_rejected"

            # add status value
            self.status_value = "5"

            # add date of rejection
            self.rejected_date = Time.now

            # Update tag on active campaign
            # ActiveCampaignService.new.contact_tag_add(self.book.user.email, "BubbleCow - Product - Sample Developmental Editing - Rejected")
        end

    end
 
end
