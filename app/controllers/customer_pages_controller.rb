class CustomerPagesController < ApplicationController
  before_action :authenticate_user!, only: [:blog_dashboard]
  before_action :set_mentoring_price, only: [:mentoring] 
  layout :set_template

  def index
    @page_title = "Affordable Book Editing Services"
    @page_description = "Book editing services for serious writers. Serving writers since 2007. 100+ testimonials."
    @testimonial_count = Testimonial.all.count
    @messages = Message.all
    @data_type = "organization"
  end

  def about
    @page_title = "About BubbleCow"
    @page_description = "BubbleCow started editing books and helping writers to success in 2007. Discover the BubbleCow story and meet our founder."
    @data_type = "local_business"
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

  def mentoring
    @page_title = "Mentoring"
    @page_description = "One-to-one professional mentoring for writers." 
    @message = Message.new
    @data_type = "product_mentoring"
  end
  

  private

  def set_template
    case action_name
    when 'index', 'mentoring'
      'full_width'
    when 'writing_manual'
      'backend'
    else
      'application'
    end
  end


  private

  def set_mentoring_price

    if Rails.env.development?
      @country = "GB"
    else
      @country = request.location.country
      # @country = "US" # - if country fails active this and block term above
    end

    case @country

    when "GB", "United Kingdom"
      @currency_symbol = "&#163;".html_safe
      @mentoring_cost = "325"
      @mentoring_price = @currency_symbol + @mentoring_cost
    else 
      @user_country = "United States"
      @currency_symbol = "&#36;".html_safe
      @mentoring_cost = "500"
      @mentoring_price = @currency_symbol + @mentoring_cost
    end
  end

end
