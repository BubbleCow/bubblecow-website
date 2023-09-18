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

    # Handles position conflicts
    def shift_positions
        # Select all lessons in the same course with a position greater than or equal to the current lesson's position
        lessons_to_shift = course.lessons.where("position >= ?", position)

        lessons_to_shift.each do |lesson|
        lesson.update_column(:position, lesson.position + 1)
        end
    end

    # Create next lesson link
    def next_lesson
        course.lessons.where('position > ?', position).order(:position).first
    end

end
