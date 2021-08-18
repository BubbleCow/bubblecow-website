class DashboardsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_nav_bar
    layout 'admin_template'

    def admin_dashboard
    
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
  