class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  layout :resolve_layout

  def index
    @page_title = "Book editing services"
    @page_description = "Empowering writers to be successful" 
  end

  def about
  end

  def terms
  end

  def privacy
  end

  def admin_dashboard
    @posts = Post.all
    @authors = PostAuthor.all
    @categories = PostCategory.all
    @testimonials = Testimonial.all
  end

  private

  def resolve_layout
    case action_name
    when "index"
      "template_no_container"
    else
      "application"
    end
  end

end
