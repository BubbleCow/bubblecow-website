class DevelopmentalEdit < ApplicationRecord
  include AASM

    # Developmental edit status 
    aasm do
      state :edit_submitted, initial: true
      state :edit_accepted
      state :edit_rejected

      event :edit_accepted do
        transitions from: :edit_submitted, to: :edit_accepted
      end

      event :edit_rejected do
        transitions from: :edit_submitted, to: :edit_rejected
      end

    end


    belongs_to  :user
    belongs_to  :genre

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
end
