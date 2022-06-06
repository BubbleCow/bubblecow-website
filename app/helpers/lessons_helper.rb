module LessonsHelper

    def lessson_content(lesson)
        content_tag(:div, lesson.content.html_safe, class: 'lesson-content' )
    end

end
