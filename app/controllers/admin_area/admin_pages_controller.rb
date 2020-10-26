module AdminArea
    class AdminPagesController < AdminArea::ApplicationController
        before_action :remove_footer
        layout 'admin_template'
        

        def dashboard
            @page_title = "Admin: Dashboard"
            authorize [:admin_area, :admin_pages]
        end

        def blog 
            @page_title = "Admin: Blog"
            authorize [:admin_area, :admin_pages]
            @posts = Post.all
            @authors = PostAuthor.all
            @categories = PostCategory.all
        end

        def testimonials
            @page_title = "Admin: Testimonials"
            authorize [:admin_area, :admin_pages]
            @testimonials = Testimonial.all
        end

        def services
            @page_title = "Admin: Services"
            authorize [:admin_area, :admin_pages]
            @developmental_edits = DevelopmentalEdit.all
        end

        def users
            @page_title = "Admin: Users"
            authorize [:admin_area, :admin_pages]
            @users = User.all
            @writers = User.writers
            @editors = User.editors
            @admins = User.admin

        end

        private

        def remove_footer
            @footer = "no footer"
        end

    end
end