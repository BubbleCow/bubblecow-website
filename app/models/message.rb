class Message < ApplicationRecord
       
    has_rich_text :content
    has_person_name

    validates :sender_name, :sender_email, :content, presence: true

    # Scopes
    default_scope { order(created_at: :desc) }
    scope :unarchived, -> {where(archived: false)}
    scope :archived, -> {where(archived: true)}
    scope :read, -> {where(read: true)}
    scope :unread, -> {where(read: false)}

    # methods
    def mark_as_read
        self.update(read: true)
    end

    def mark_as_unread
        self.update(read: false)
    end

    def mark_as_archived
        self.update(archived: true)
    end

    def mark_as_unarchived
        self.update(archived: false)
    end
end
