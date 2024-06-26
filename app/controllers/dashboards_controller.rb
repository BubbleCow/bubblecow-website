class DashboardsController < ApplicationController
    before_action :authenticate_user!
    layout :set_layout

    def show
        @page_title = 'Dashboard'
        @user = current_user
        @books = current_user.books

        @developmental_edits = @user.developmental_edits.order(created_at: :desc)
        @number_of_developmental_edits = @developmental_edits.count

        @sample_developmental_edits = @user.sample_developmental_edits.order(created_at: :desc)
        @number_of_sample_developmental_edits = @sample_developmental_edits.count

        @jobs = @user.developmental_edits.order(created_at: :desc) + @user.sample_developmental_edits.order(created_at: :desc)

        @courses = Course.all
        @ebooks = Ebook.all

        @user_signup_data = User.group_by_week(:created_at, last: 52).count
        
        # Renders the correct template
        render "#{@user.role}_dashboard", fallbacks: ['escape_dashboard']

    end

    private

    def set_layout
      case action_name
      when 
          'page_templates/page_small'
      when 'show'
          'page_templates/page_medium'
      when 
          'page_templates/page_large'
      else
        'application'
      end
    end
    
    
end
  