module CoursesHelper

    # Logic to determine if the user has access to the course.
    def user_has_access?(course)
        # Anyone logged in can access a free course
        return true if course.access_level == 'free' && current_user

        # For other courses, only logged-in paid users, staff, or admins have access
        current_user && (current_user.paid_user? || current_user.staff? || current_user.admin?)
    end

    # Logic for course index button
    def course_button_details(course, current_user)
        if user_has_access?(course)
        ["Take Course", "btn-primary"]
        elsif course.access_level == 'free' && !current_user
        ["Sign in to take course", "btn-secondary"]
        else
        ["See More Details", "btn-secondary"]
        end
    end
    
end
