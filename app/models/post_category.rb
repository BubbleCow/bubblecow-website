class PostCategory < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
  
    # Existing code for friendly_id
    def should_generate_new_friendly_id?
      name_changed?
    end
  
    # Association with posts
    has_many :posts
  
    # Self-referential associations for parent and child categories
    belongs_to :parent_category, class_name: 'PostCategory', optional: true
    has_many :child_categories, class_name: 'PostCategory', foreign_key: 'parent_category_id'

  
    private
  
    def parent_category_cannot_be_self
      errors.add(:parent_category_id, "can't be the same as id") if parent_category_id == id
    end
  
    # Default scope
    default_scope { order(created_at: :desc) }
  end
  