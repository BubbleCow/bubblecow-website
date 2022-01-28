class DevEdit < ApplicationRecord

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
 
     # Check status and carries out required actions
     def update_edit_status_information(status)
 
         if status == "developmental_edit_created"
 
             # add status value
             self.update(status_value: 1)
 
         elsif status == "developmental_edit_accepted"
 
             # add status value and add date of accetptance
             self.update(status_value: 2, accepted_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Accepted")
 
         elsif status == "developmental_edit_invoice_sent"
 
             # add status value
             self.update(status_value: 3)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Invoice Sent")
 
         elsif status == "developmental_edit_invoice_paid"
 
             # add status value
             self.update(status_value: 4)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Invoice Paid")
 
         elsif status == "developmental_edit_editing_underway"
 
             # add status value
             self.update(status_value: 5)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Editing Underway")
     
         elsif status == "developmental_edit_returned"
 
             # add status value and add date of rejection
             self.update(status_value: 6, return_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Edit Returned")
 
         elsif status == "developmental_edit_rejected"
  
             # add status value and add date of rejection
             self.update(status_value: 7, rejected_date: Time.now)
 
             # Send lead to Active Campaign
             ActiveCampaignService.new.contact_tag_add(self.book.user, "BubbleCow - Product - Developmental Editing - Rejected")
 
         end
 
     end
     
end
