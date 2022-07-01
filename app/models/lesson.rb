class Lesson < ApplicationRecord

    # Relationships
    belongs_to :course

    extend FriendlyId
    friendly_id :title, use: :slugged

    def should_generate_new_friendly_id?
        title_changed?
    end

    # validations
    validates :title, presence: true

end
