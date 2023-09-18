class DashboardsController < ApplicationController
    before_action :authenticate_user!

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
        
        # Renders the correct template
        render "#{@user.role}_dashboard", fallbacks: ['escape_dashboard']
    end
    
end
  