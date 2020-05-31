class DevelopmentalEdit < ApplicationRecord
    belongs_to  :user

    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    validates :title, presence: true
    
    # Scopes
    default_scope { order(created_at: :desc) }
end
