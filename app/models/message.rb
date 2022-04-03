class Message < ApplicationRecord
    
    broadcasts_to ->(message) {'messages'}, target: :message
    
    has_rich_text :content
    has_person_name

    validates :sender_name, :sender_email, :content, presence: true

    # Scopes
    default_scope { order(created_at: :desc) }
    scope :unarchived, -> {where(archived: false)}
    scope :archived, -> {where(archived: true)}
    scope :read, -> {where(read: true)}
    scope :unread, -> {where(read: false)}

    def mark_as_read(message)
        self.update(read: true)
    end
end
