class DashboardsController < ApplicationController
    before_action :authenticate_user!

    def admin_dashboard

    end

    def manager_dashboard
    end

    def content_creator_dashboard
        @posts = Post.all
    end

    def writer_dashboard
        @page_title = "Author Dashboard"
        @page_description = "A hub for all your editorial services."

        @developmental_edits = current_user.developmental_edits.order(created_at: :desc)
        @number_of_developmental_edits = @developmental_edits.count

        @sample_developmental_edits = current_user.sample_developmental_edits.order(created_at: :desc)
        @number_of_sample_developmental_edits = @sample_developmental_edits.count

        @jobs = current_user.developmental_edits.order(created_at: :desc) + current_user.sample_developmental_edits.order(created_at: :desc)
    end
    
end
  