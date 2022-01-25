class CustomerPagesController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  layout :set_template

  def index
    @page_title = "Affordable Book Editing Services"
    @page_description = "Book editing services for serious writers. Serving writers since 2007. 100+ testimonials."
    @testimonial_count = Testimonial.all.count
  end

  def about
    @page_title = "About BubbleCow"
    @page_description = "BubbleCow started editing books and helping writers to success in 2007. Discover the BubbleCow story and meet our founder."
  end

  def thanks
    @page_title = "Thanks for your payment"
    @page_description = "Thanks for payment. We will be in touch shortly."
    @footer = "no footer"
  end

  def writing_manual
    @footer = "no footer"
  end 

  def file_safety
    @page_title = "File Safety"
    @page_description = "Discover how we ensure your manuscript is kept safe." 
  end

  private

  def set_template
    case action_name
    when 'index'
      'full_width'
    when 'writing_manual'
      'backend'
    else
      'application'
    end
  end

end
