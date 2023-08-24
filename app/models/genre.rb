class Genre < ApplicationRecord
    has_many :developmental_edits, dependent: :destroy
    has_many :sample_developmental_edits, dependent: :destroy
    has_many :books, dependent: :destroy

    validates :genre_type, presence: true

    extend FriendlyId
    friendly_id :genre_type, use: :slugged

    def should_generate_new_friendly_id?
        genre_type_changed?
    end
end
