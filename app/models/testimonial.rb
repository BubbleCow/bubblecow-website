class Testimonial < ApplicationRecord

    has_rich_text :testimonial_text

    extend FriendlyId
    friendly_id :writer, use: :slugged

    def should_generate_new_friendly_id?
        writer_changed?
    end

    validates :writer, :testimonial_text, presence: true
    
    # Scopes
    default_scope { order(created_at: :desc) }
    scope :approved, -> {where(approved: true)}
end
