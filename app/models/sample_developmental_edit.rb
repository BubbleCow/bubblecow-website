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
    has_one_attached :sample_developmental_edit_manuscript

    validates :title, presence: true
    validates :word_count, numericality: { greater_than_or_equal_to: 15000 }
end
