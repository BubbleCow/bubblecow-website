class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

  def self.visits_excluding_messages_new(time_frame, group_by)
    where.not("landing_page LIKE ?", "%/messages/new")
      .send(group_by, :started_at, last: time_frame, format: group_by_format(group_by))
      .count
  end

  private

  def self.group_by_format(group_by)
    group_by == :group_by_day ? "%-d %b" : "%b %Y"
  end
end
