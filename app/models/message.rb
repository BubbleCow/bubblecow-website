class Message < ApplicationRecord
    has_rich_text :content
    has_person_name

    validates :sender_name, :sender_email, :content, presence: true

    # Scopes
    default_scope { order(created_at: :desc) }
    scope :active, -> {where(archived: false)}
    scope :archived, -> {where(archived: true)}
    scope :read, -> {active.where(read: true)}
    scope :unread, -> {active.where(read: false)}

    def mark_as_read(message)
        self.update_attributes!(read: true)
    end
end
