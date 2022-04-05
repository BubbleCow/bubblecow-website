module UserHelper

  # This helper focuses on ways in which we interact with the user.

  # Restricts to management
  def user_is_management
    current_user.manager? || current_user.admin?
  end

  # Restricts to editorial
  def user_is_editorial_staff
      current_user.editor? || current_user.manager? || current_user.admin?
  end

  # Restricts to marketing
  def user_is_marketing_staff
      current_user.content_creator? || current_user.manager? || current_user.admin?
  end

  # Restricts to management
  def user_is_writer
    current_user.writer?
  end

  # Provides last loggr in if present
  def last_time_logged_in(user)
    user.last_sign_in_at.strftime("%B %d, %Y") if user.last_sign_in_at.present? 
  end

end