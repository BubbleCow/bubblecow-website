class SampleDevelopmentalEdit < ApplicationRecord
    before_save :check_state, if: :will_save_change_to_aasm_state?
    belongs_to  :user
    belongs_to  :editor, class_name: "User", foreign_key: "editor_id", optional: true
    belongs_to  :genre
  
    include AASM 

    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    has_rich_text :description
    has_rich_text :note
    has_one_attached :sample_developmental_edit_manuscript
    has_one_attached :sample_editors_report
    has_one_attached :sample_edited_manuscript

    validates :title, presence: true
    validates :word_count, numericality: { greater_than_or_equal_to: 15000 }

    # Scopes
    scope :sorted_by_due_date, -> { order(developmental_edit_due_date: :asc) }
    scope :sample_developmental_edit_submitted, -> { where(aasm_state: "sample_developmental_edit_submitted") }
    scope :sample_developmental_edit_accepted, -> { where(aasm_state: "sample_developmental_edit_accepted") }
    scope :sample_developmental_edit_editing_underway, -> { where(aasm_state: "sample_developmental_edit_editing_underway") }

    # Sample developmental edititng process 
    aasm do
        state :sample_developmental_edit_submitted, initial: true
        state :sample_developmental_edit_rejected
        state :sample_developmental_edit_accepted
        state :sample_developmental_edit_editing_underway
        state :sample_developmental_edit_returned

        # Sample Developmental editing rejected
        event :sample_developmental_edit_rejected do
          transitions from: :sample_developmental_edit_submitted, to: :sample_developmental_edit_rejected
        end


        # Sample Developmental edit accepted    
        event :sample_developmental_edit_accepted do
          transitions from: :sample_developmental_edit_submitted, to: :sample_developmental_edit_accepted
        end
    
      end
        
      def calculate_developmental_edit_quote(service_price)
        self.update_attribute(:developmental_editing_quote, service_price*self.word_count/1000)
      end

    private 

    def check_state
      case aasm_state 

      when "sample_developmental_edit_submitted"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Service - Sample Developmental Editing - Submitted") 
        
        # #  Send email to user
        # SampleDevelopmentalEditMailer.new_sample_developmental_edit(self.user, self).deliver_now

        # Send email to admin 
        SampleDevelopmentalEditMailer.new_sample_developmental_edit_admin(self.user, self).deliver_now
      
      when "sample_developmental_edit_rejected"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Service - Sample Developmental Editing - Rejected")

        # # Send email
        # SampleDevelopmentalEditMailer.sample_developmental_edit_rejected(self.user, self).deliver

      when "sample_developmental_edit_accepted"

        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Service - Sample Developmental Editing - Accepted")                
        
        # Send email to writer
        SampleDevelopmentalEditMailer.sample_developmental_edit_accepted(self.user, self).deliver
      
      when "sample_developmental_edit_editing_underway"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Service - Sample Developmental Editing - Editing Underway") 

        # Send email to editor to tell them they have an edit
        SampleDevelopmentalEditMailer.sample_developmental_edit_editing_underway_editor(self.user, self).deliver

      when "sample_developmental_edit_returned"
        # Update active campaign tag
        ActiveCampaignService.new.contact_tag_add(self.user.email, "Service - Sample Developmental Editing - Edit Returned") 

        # # Send email to writer to say edit is ready
        # SampleDevelopmentalEditMailer.sample_developmental_edit_returned(self.user, self).deliver

      end

    end

end
