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
        
        # Renders the correct template
        render "#{@user.role}_dashboard", fallbacks: ['escape_dashboard']

        @visits_12_months = Ahoy::Visit.visits_excluding_messages_new(12, :group_by_month)
        @visits_24_months = Ahoy::Visit.visits_excluding_messages_new(24, :group_by_month)
        @visits_last_week = Ahoy::Visit.visits_excluding_messages_new(7, :group_by_day)
        @visits_last_month = Ahoy::Visit.visits_excluding_messages_new(30, :group_by_day)

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
  