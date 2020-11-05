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
            @service_prices = ServicePrice.all
        end

        def users
            @page_title = "Admin: Users"
            authorize [:admin_area, :admin_pages]
            @users = User.all
            @writers = User.writers
            @editors = User.editors
            @admins = User.admin
        end

        def genres
            @page_title = "Admin: Genre"
            authorize [:admin_area, :admin_pages]
            @genres = Genre.all.order('genre_type ASC')
        end

        def prices
            @page_title = "Admin: prices"
            authorize [:admin_area, :admin_pages]
            @service_prices = ServicePrice.all
        end

        private

        def remove_footer
            @footer = "no footer"
        end

    end
end