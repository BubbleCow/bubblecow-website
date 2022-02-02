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

end