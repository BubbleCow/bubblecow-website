class DevEditSample < ApplicationRecord

    # Callbacks
     after_save :check_status, if: :will_save_change_to_status?
    
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
     scope :submitted, -> {where(status: "sample_developmental_edit_created")}
 
     # Check status and carries out required actions
     def check_status
        ActiveCampaignService.new.contact_tag_add(self.book.user, "new testing status")
     end




     def update_sample_status_information(status)
 
        if status == "sample_developmental_edit_created"

            # Send tag to Active Campaign
            ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Sample Developmental Editing - Submitted")
    
        elsif status == "sample_developmental_edit_accepted"
 
             # add status value + Add date of acceptance
             self.update(status_value: 2, accepted_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Sample Developmental Editing - Accepted")
 
         elsif status == "sample_developmental_edit_editing_underway"
 
             # add status value
             self.update(status_value: 3)
 
         elsif status == "sample_developmental_edit_returned"
 
             # add status value
             self.update(status_value: 4, return_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Sample Developmental Editing - Edit Returned")
 
         elsif status == "sample_developmental_edit_rejected"
                 
             # add status value + Add date of rejection
             self.update(status_value: 5, rejected_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Sample Developmental Editing - Rejected")
 
         end
         
     end
 
end
