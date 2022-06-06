module CoursesHelper

    def course_description(course)
        content_tag(:div, course.description.html_safe, class: 'course-description' )
    end
    
end
