class Book < ApplicationRecord

    # Relationsships
    belongs_to :user
    belongs_to :genre
    has_many :dev_edits, dependent: :destroy
    has_many :dev_edit_samples, dependent: :destroy

    # Action text
    has_rich_text :description

    # Validations
    validates :title, presence: true
    validates :description, presence: true
    validates :word_count, numericality: { greater_than_or_equal_to: 15000,  only_integer: true }
    validates :language, presence: true
    validates :genre_id, presence: true

    # Friendly_id
    extend FriendlyId
    friendly_id :title, use: :slugged

    # Alters friendly ID if title changed
    def should_generate_new_friendly_id?
        title_changed?
    end 

    # Scopes
    scope :has_sample_developmental_edit, -> {where_assoc_exists(:dev_edit_samples)}
    scope :has_developmental_edit, -> {where_assoc_exists(:dev_edits)}

end
