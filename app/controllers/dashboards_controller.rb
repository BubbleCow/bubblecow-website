class DashboardsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_nav_bar
    layout 'admin_template'

    def admin_dashboard
    
    end

    def writer_dashboard
        @page_title = "Author Dashboard"
        @page_description = "A hub for all your editorial services."
        @developmental_edits = current_user.developmental_edits.order(created_at: :desc)
        @sample_developmental_edits = current_user.sample_developmental_edits.order(created_at: :desc)
        @jobs = current_user.developmental_edits.order(created_at: :desc) + current_user.sample_developmental_edits.order(created_at: :desc)
    end
  
    
    def blog_dashboard
        @posts = Post.all
    end

    private

    def set_admin_nav_bar
        @unread_messages = Message.unread
        @unprocessed_developmental_edits = DevelopmentalEdit.developmental_edit_submitted
        @unprocessed_sample_developmental_edits = SampleDevelopmentalEdit.sample_developmental_edit_submitted
    end
    
end
  