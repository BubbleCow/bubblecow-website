class Genre < ApplicationRecord
    has_many :developmental_edits, dependent: :destroy
    has_many :sample_developmental_edits, dependent: :destroy
    has_many :books

    # Self-referential associations
    belongs_to :parent, class_name: 'Genre', optional: true
    has_many :children, class_name: 'Genre', foreign_key: 'parent_id', dependent: :destroy
   

    validates :genre_type, presence: true

    extend FriendlyId
    friendly_id :genre_type, use: :slugged

    def should_generate_new_friendly_id?
        genre_type_changed?
    end

    # Method to fetch all sub-genres
    def all_subgenres
        children.each_with_object(children.to_a) do |child, arr|
            arr.concat(child.all_subgenres)
        end
    end

end
