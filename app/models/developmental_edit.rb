class DevelopmentalEdit < ApplicationRecord
  before_save :check_state, if: :will_save_change_to_aasm_state?
  belongs_to  :user
  belongs_to  :genre
  
  include AASM 

    has_rich_text :description
    has_rich_text :note
    has_one_attached :full_manuscript

    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    validates :title, presence: true
    validates :word_count, numericality: { greater_than_or_equal_to: 15000 }
    
    # Scopes
    default_scope { order(created_at: :desc) }


    # STATES - https://www.driftingruby.com/episodes/state-machines 

    # Developmental edititng process 
    aasm do
      state :developmental_edit_submitted, initial: true
      state :developmental_edit_rejected
      state :developmental_edit_accepted
      state :developmental_edit_invoice_sent
      state :developmental_edit_invoice_paid
      

      # Developmental edit accepted    
      event :developmental_edit_accepted do
        transitions from: :developmental_edit_submitted, to: :developmental_edit_accepted
      end

      # Developmental editing rejected
      event :developmental_edit_rejected do
        transitions from: :developmental_edit_submitted, to: :developmental_edit_rejected
      end

      event :developmental_editing_process do
        transitions from: :developmental_edit_accepted, to: :developmental_edit_invoice_sent

      end

    end

    private    
    def check_state
      case aasm_state 

      when "developmental_edit_rejected"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Product - Developmental Editing - Rejected")

        # Send email
        DevelopmentalEditMailer.developmental_edit_rejected(self.user, self).deliver

      when "developmental_edit_accepted"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Product - Developmental Editing - Accepted")                
        
        # Send email
        DevelopmentalEditMailer.developmental_edit_accepted(self.user, self).deliver

      when "developmental_edit_invoice_sent"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Product - Developmental Editing - Invoice Sent") 

        # Send email
        DevelopmentalEditMailer.developmental_edit_invoice_sent(self.user, self).deliver

      when "developmental_edit_invoice_paid"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Product - Developmental Editing - Invoice Paid") 

        # Send email
        DevelopmentalEditMailer.developmental_edit_invoice_paid(self.user, self).deliver
      
      end

    end
end
